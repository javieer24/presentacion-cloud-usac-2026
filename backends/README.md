Backend Services for FinTech Architecture Demonstration

Dos servicios microservicios implementados en Python y Node.js para demostración de arquitectura financiera escalable.

## Servicios Disponibles

### Backend 1: Python - Transaction API (Puerto 5000)

Servicio de procesamiento de transacciones financieras.

**Endpoints**:
- POST /transactions - Crear nueva transacción
- GET /transactions/<transaction_id> - Obtener transacción
- GET /balance/<user_id> - Calcular balance de usuario
- GET /metrics - Obtener métricas del servicio
- GET /health - Health check

**Tecnologías**:
- Framework: Flask 2.3
- Base de datos: DynamoDB (AWS)
- Almacenamiento: S3 (fallback)
- Lenguaje: Python 3.9+

**Requisitos**:
- Python 3.9 o superior
- Pip (gestor de paquetes Python)
- Credenciales AWS configuradas

### Backend 2: Node.js - Audit API (Puerto 3000)

Servicio de auditoría y reporte de transacciones.

**Endpoints**:
- POST /audit-log - Crear registro de auditoría
- GET /audit-log/<log_id> - Obtener registro
- GET /audit-logs/user/<user_id> - Obtener logs de usuario
- POST /report - Generar reporte
- GET /metrics - Obtener métricas
- GET /health - Health check

**Tecnologías**:
- Framework: Express 4.18
- Base de datos: DynamoDB (AWS)
- Monitoreo: CloudWatch
- Lenguaje: Node.js 16+

**Requisitos**:
- Node.js 16 o superior
- NPM (Node Package Manager)
- Credenciales AWS configuradas

## Setup - Paso a Paso

### Paso 1: Configurar Credenciales AWS

**Opción A: AWS CLI (Recomendado)**

```bash
aws configure
AWS Access Key ID: [Tu Access Key]
AWS Secret Access Key: [Tu Secret Key]
Default region name: us-east-1
Default output format: json
```

Las credenciales se almacenan en ~/.aws/credentials (Unix/Mac) o %USERPROFILE%\.aws\credentials (Windows).

**Opción B: Variables de Entorno**

```bash
export AWS_ACCESS_KEY_ID=tu_access_key
export AWS_SECRET_ACCESS_KEY=tu_secret_key
export AWS_REGION=us-east-1
```

### Paso 2: Backend Python

**Instalación**:

```bash
cd backends/python
pip install -r requirements.txt
```

**Configuración**:

```bash
cp .env.example .env
nano .env  # Edita si necesitas valores diferentes
```

**Ejecución**:

```bash
python app.py
# O con Gunicorn (producción)
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

**Verificación**:

```bash
curl http://localhost:5000/health
```

Respuesta esperada:
```json
{
  "status": "healthy",
  "service": "Transaction API",
  "timestamp": "2026-10-06T15:30:00.000000"
}
```

### Paso 3: Backend Node.js

**Instalación**:

```bash
cd backends/nodejs
npm install
```

**Configuración**:

```bash
cp .env.example .env
nano .env  # Edita si necesitas valores diferentes
```

**Ejecución**:

```bash
npm start
# O en desarrollo con nodemon
npm run dev
```

**Verificación**:

```bash
curl http://localhost:3000/health
```

Respuesta esperada:
```json
{
  "status": "healthy",
  "service": "Audit API",
  "timestamp": "2026-10-06T15:30:00.000Z"
}
```

## Ejemplos de Uso

### Crear Transacción (Python)

```bash
curl -X POST http://localhost:5000/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "user123",
    "amount": 150.50,
    "currency": "USD",
    "metadata": {
      "merchant": "AWS Store",
      "category": "cloud-services"
    }
  }'
```

Respuesta:
```json
{
  "transaction_id": "TXN-1696610400.000000",
  "user_id": "user123",
  "amount": 150.5,
  "currency": "USD",
  "status": "completed",
  "timestamp": "2026-10-06T15:30:00.000000",
  "metadata": {
    "merchant": "AWS Store",
    "category": "cloud-services"
  }
}
```

### Crear Registro de Auditoría (Node.js)

```bash
curl -X POST http://localhost:3000/audit-log \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "admin001",
    "action": "transaction_created",
    "resource": "transaction:TXN-1696610400",
    "status": "completed",
    "details": {
      "amount": 150.50,
      "user_affected": "user123"
    }
  }'
```

### Obtener Balance (Python)

```bash
curl http://localhost:5000/balance/user123
```

Respuesta:
```json
{
  "user_id": "user123",
  "balance": 150.5,
  "transaction_count": 1,
  "timestamp": "2026-10-06T15:30:00.000000"
}
```

### Obtener Logs de Auditoría (Node.js)

```bash
curl "http://localhost:3000/audit-logs/user/admin001?limit=50"
```

## Seguridad

### Credenciales AWS

NUNCA hardcodear credenciales en el código. Usar:
- Variables de entorno
- AWS CLI configuration (~/.aws/credentials)
- IAM roles (cuando se ejecuta en EC2/Lambda)

### CORS

Ambos servicios tienen CORS habilitado para desarrollo. En producción:
- Especificar dominio permitido: ALLOWED_ORIGINS=https://midominio.com
- Implementar autenticación (JWT, OAuth)

### Validación de Entrada

Ambos servicios validan:
- Campos requeridos
- Tipos de datos
- Rango de valores

### Logging

Ambos servicios registran:
- Requests y responses
- Errores y excepciones
- Eventos importantes (transacción creada, etc.)

Consultar logs:
- Python: stdout/stderr o archivo
- Node.js: stdout/stderr o fichero de logs

## Troubleshooting

### "DynamoDB table not found"

Asegúrate de que:
- La tabla existe en DynamoDB (us-east-1)
- Las credenciales AWS tienen permisos DynamoDB
- El nombre de tabla en .env es correcto

### "Access Denied" (AWS)

Verifica:
- Las credenciales en ~/.aws/credentials son correctas
- El usuario tiene permisos DynamoDB, S3, CloudWatch

### "Port already in use"

Cambiar puerto en .env:
```bash
PORT=5001  # Python
PORT=3001  # Node.js
```

### "Module not found"

Reinstalar dependencias:
```bash
pip install -r requirements.txt  # Python
npm install  # Node.js
```

## Integración con AWS

### DynamoDB Tables Requeridas

**Para Python (Transaction API)**:
```
Table: FinTech-Transactions
Primary Key: transaction_id (String)
```

**Para Node.js (Audit API)**:
```
Table: FinTech-Audit-Logs
Primary Key: log_id (String)
```

### S3 Bucket Requerido (Python)

```
Bucket: fintech-transactions-logs
Purpose: Almacenamiento de respaldo
```

### CloudWatch (Node.js)

Namespace: FinTech/AuditAPI
Métricas: AuditLogCreated, ReportGenerated

## Monitoreo

### Python - CloudWatch Logs

```bash
aws logs tail /aws/lambda/transaction-api --follow
```

### Node.js - CloudWatch Logs

```bash
aws logs tail /aws/lambda/audit-api --follow
```

### Métricas Personalizadas

Ambos servicios publican métricas. Ver en CloudWatch:
- FinTech/TransactionAPI (Python)
- FinTech/AuditAPI (Node.js)

## Próximos Pasos

1. Desplegar en EC2 o Lambda
2. Configurar ALB (Application Load Balancer) en frente
3. Implementar autenticación (JWT)
4. Agregar tests unitarios
5. Configurar CI/CD (GitHub Actions, CodePipeline)
6. Monitoreo avanzado (X-Ray, detailed CloudWatch)

## Licencia

Educational - Propósito de demostración técnica

## Contacto

Para preguntas técnicas sobre los backends contactar al instructor.

---

Version: 1.0 - Oficial
Última actualización: Octubre 2026
