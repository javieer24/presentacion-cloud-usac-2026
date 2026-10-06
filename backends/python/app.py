from flask import Flask, request, jsonify
from flask_cors import CORS
import boto3
from dotenv import load_dotenv
import os
import json
from datetime import datetime
import logging

load_dotenv()

app = Flask(__name__)
CORS(app)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

AWS_REGION = os.getenv('AWS_REGION', 'us-east-1')
dynamodb = boto3.resource('dynamodb', region_name=AWS_REGION)
s3_client = boto3.client('s3', region_name=AWS_REGION)

transactions_table = dynamodb.Table(os.getenv('DYNAMODB_TABLE', 'FinTech-Transactions'))
s3_bucket = os.getenv('S3_BUCKET', 'fintech-transactions-logs')

@app.route('/health', methods=['GET'])
def health():
    return jsonify({
        'status': 'healthy',
        'service': 'Transaction API',
        'timestamp': datetime.utcnow().isoformat()
    }), 200

@app.route('/transactions', methods=['POST'])
def create_transaction():
    try:
        data = request.get_json()

        required_fields = ['user_id', 'amount', 'currency']
        if not all(field in data for field in required_fields):
            return jsonify({'error': 'Missing required fields'}), 400

        transaction_id = f"TXN-{datetime.utcnow().timestamp()}"

        transaction = {
            'transaction_id': transaction_id,
            'user_id': data.get('user_id'),
            'amount': float(data.get('amount')),
            'currency': data.get('currency'),
            'status': 'completed',
            'timestamp': datetime.utcnow().isoformat(),
            'metadata': data.get('metadata', {})
        }

        try:
            transactions_table.put_item(Item=transaction)
            logger.info(f"Transaction created: {transaction_id}")
        except Exception as e:
            logger.warning(f"DynamoDB unavailable, transaction saved to S3: {str(e)}")
            s3_key = f"transactions/{transaction_id}.json"
            s3_client.put_object(
                Bucket=s3_bucket,
                Key=s3_key,
                Body=json.dumps(transaction),
                ContentType='application/json'
            )

        return jsonify(transaction), 201

    except Exception as e:
        logger.error(f"Error creating transaction: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@app.route('/transactions/<transaction_id>', methods=['GET'])
def get_transaction(transaction_id):
    try:
        response = transactions_table.get_item(Key={'transaction_id': transaction_id})

        if 'Item' not in response:
            return jsonify({'error': 'Transaction not found'}), 404

        return jsonify(response['Item']), 200

    except Exception as e:
        logger.error(f"Error fetching transaction: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@app.route('/balance/<user_id>', methods=['GET'])
def get_balance(user_id):
    try:
        response = transactions_table.scan(
            FilterExpression='user_id = :uid',
            ExpressionAttributeValues={':uid': user_id}
        )

        transactions = response.get('Items', [])
        total_balance = sum(float(t.get('amount', 0)) for t in transactions)

        return jsonify({
            'user_id': user_id,
            'balance': total_balance,
            'transaction_count': len(transactions),
            'timestamp': datetime.utcnow().isoformat()
        }), 200

    except Exception as e:
        logger.error(f"Error calculating balance: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@app.route('/metrics', methods=['GET'])
def get_metrics():
    try:
        response = transactions_table.scan()
        items = response.get('Items', [])

        metrics = {
            'total_transactions': len(items),
            'total_volume': sum(float(t.get('amount', 0)) for t in items),
            'service_status': 'operational',
            'timestamp': datetime.utcnow().isoformat()
        }

        return jsonify(metrics), 200

    except Exception as e:
        logger.error(f"Error calculating metrics: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Endpoint not found'}), 404

@app.errorhandler(500)
def server_error(error):
    return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_ENV') == 'development'
    app.run(host='0.0.0.0', port=port, debug=debug)
