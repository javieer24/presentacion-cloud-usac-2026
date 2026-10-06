const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const AWS = require('aws-sdk');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;
const AWS_REGION = process.env.AWS_REGION || 'us-east-1';

app.use(cors());
app.use(express.json());
app.use(morgan('combined'));

AWS.config.update({ region: AWS_REGION });
const cloudwatch = new AWS.CloudWatch();
const dynamodb = new AWS.DynamoDB.DocumentClient();

const auditTableName = process.env.DYNAMODB_AUDIT_TABLE || 'FinTech-Audit-Logs';

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    service: 'Audit API',
    timestamp: new Date().toISOString()
  });
});

app.post('/audit-log', (req, res) => {
  try {
    const { user_id, action, resource, status, details } = req.body;

    if (!user_id || !action || !resource) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const auditLog = {
      log_id: `AUDIT-${Date.now()}`,
      user_id,
      action,
      resource,
      status: status || 'completed',
      timestamp: new Date().toISOString(),
      details: details || {},
      ip_address: req.ip,
      user_agent: req.get('User-Agent')
    };

    const params = {
      TableName: auditTableName,
      Item: auditLog
    };

    dynamodb.put(params, (err, data) => {
      if (err) {
        console.error('DynamoDB error:', err);
        return res.status(500).json({ error: 'Failed to log audit' });
      }

      publishMetric('AuditLogCreated', 1);
      res.status(201).json(auditLog);
    });

  } catch (error) {
    console.error('Error creating audit log:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/audit-log/:log_id', (req, res) => {
  try {
    const { log_id } = req.params;

    const params = {
      TableName: auditTableName,
      Key: { log_id }
    };

    dynamodb.get(params, (err, data) => {
      if (err) {
        console.error('DynamoDB error:', err);
        return res.status(500).json({ error: 'Failed to fetch audit log' });
      }

      if (!data.Item) {
        return res.status(404).json({ error: 'Audit log not found' });
      }

      res.status(200).json(data.Item);
    });

  } catch (error) {
    console.error('Error fetching audit log:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/audit-logs/user/:user_id', (req, res) => {
  try {
    const { user_id } = req.params;
    const limit = req.query.limit ? parseInt(req.query.limit) : 100;

    const params = {
      TableName: auditTableName,
      FilterExpression: 'user_id = :uid',
      ExpressionAttributeValues: {
        ':uid': user_id
      },
      Limit: limit
    };

    dynamodb.scan(params, (err, data) => {
      if (err) {
        console.error('DynamoDB error:', err);
        return res.status(500).json({ error: 'Failed to fetch audit logs' });
      }

      res.status(200).json({
        user_id,
        count: data.Items.length,
        logs: data.Items,
        timestamp: new Date().toISOString()
      });
    });

  } catch (error) {
    console.error('Error fetching user audit logs:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/report', (req, res) => {
  try {
    const { report_type, user_id, date_from, date_to } = req.body;

    if (!report_type || !user_id) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const report = {
      report_id: `REPORT-${Date.now()}`,
      report_type,
      user_id,
      date_range: { from: date_from, to: date_to },
      generated_at: new Date().toISOString(),
      status: 'completed',
      data: {
        total_actions: 0,
        by_action_type: {},
        by_resource_type: {}
      }
    };

    publishMetric('ReportGenerated', 1);
    res.status(201).json(report);

  } catch (error) {
    console.error('Error generating report:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/metrics', (req, res) => {
  try {
    const params = {
      TableName: auditTableName
    };

    dynamodb.scan(params, (err, data) => {
      if (err) {
        console.error('DynamoDB error:', err);
        return res.status(500).json({ error: 'Failed to calculate metrics' });
      }

      const items = data.Items || [];
      const actionCounts = {};

      items.forEach(log => {
        actionCounts[log.action] = (actionCounts[log.action] || 0) + 1;
      });

      res.status(200).json({
        total_audit_logs: items.length,
        by_action_type: actionCounts,
        service_status: 'operational',
        timestamp: new Date().toISOString()
      });
    });

  } catch (error) {
    console.error('Error calculating metrics:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

function publishMetric(metricName, value) {
  const params = {
    Namespace: 'FinTech/AuditAPI',
    MetricData: [
      {
        MetricName: metricName,
        Value: value,
        Unit: 'Count',
        Timestamp: new Date()
      }
    ]
  };

  cloudwatch.putMetricData(params, (err, data) => {
    if (err) {
      console.error('CloudWatch error:', err);
    }
  });
}

app.use((req, res) => {
  res.status(404).json({ error: 'Endpoint not found' });
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'Internal server error' });
});

app.listen(PORT, () => {
  console.log(`Audit API listening on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`AWS Region: ${AWS_REGION}`);
});
