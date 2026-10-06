# Checklist de Arquitectura FinTech en AWS

Use esta lista para verificar que una arquitectura de procesamiento de pagos cumple mejores prácticas de seguridad, disponibilidad y costo.

## Networking

### VPC & Subredes
- [ ] VPC creada con CIDR Block apropiado (ej: 10.0.0.0/16)
- [ ] Mínimo 2 Availability Zones configuradas
- [ ] Subredes públicas creadas en cada AZ (para ALB)
- [ ] Subredes privadas creadas en cada AZ (para aplicación)
- [ ] Subredes DB creadas en cada AZ, sin ruta IGW
- [ ] Route tables asociadas correctamente a cada subred

### Internet & NAT
- [ ] Internet Gateway creado y attached a VPC
- [ ] NAT Gateway creado en CADA subred pública (mínimo 2)
- [ ] Route tables públicas: 0.0.0.0/0 → IGW
- [ ] Route tables privadas: 0.0.0.0/0 → NAT Gateway (en su AZ)
- [ ] Elastic IPs asignadas a NAT Gateways

### Seguridad de Red
- [ ] Security Group para ALB: 443 desde 0.0.0.0/0 ✓
- [ ] Security Group para ALB: 80 redirige a 443 ✓
- [ ] Security Group para Aplicación: 8080 SOLO desde SG-ALB
- [ ] Security Group para Aplicación: Outbound permitido (internet, BD)
- [ ] Security Group para RDS: 5432 SOLO desde SG-Aplicación
- [ ] NACLs revisadas (default usualmente suficiente)
- [ ] VPC Flow Logs habilitados (auditoría de tráfico)

## Cómputo

### Application Load Balancer
- [ ] ALB creado en subredes públicas (multi-AZ)
- [ ] Health checks configurados (healthy threshold: 2, unhealthy: 3)
- [ ] Target Group apuntando a ASG
- [ ] Listener 443 (HTTPS) con certificado SSL/TLS válido
- [ ] Listener 80 redirige a 443
- [ ] Access logs habilitados (S3 destino)

### Auto Scaling Group
- [ ] Min Instances: 2 (mínimo para HA)
- [ ] Max Instances: 20 (límite de costo)
- [ ] Desired Capacity: 2 (inicial)
- [ ] Scaling Policies: CPU > 70% scale up, CPU < 30% scale down
- [ ] Cooldown period: 5 minutos (evita oscilaciones)
- [ ] Health checks: ALB, grace period 300s
- [ ] Launch template con AMI correcta (OS, drivers, app)
- [ ] IAM instance profile asignado (para acceso S3, Secrets Manager)

### Instancias EC2
- [ ] Tipo: t3.medium o superior (recomendado para apps)
- [ ] AMI actualizada (OS patches aplicados)
- [ ] Storage: 30GB mínimo (gp3)
- [ ] Security groups aplicados correctamente
- [ ] Monitoring CloudWatch habilitado (CPU, memoria, disco)
- [ ] Logs enviados a CloudWatch (aplicación, sistema)

## Base de Datos

### RDS PostgreSQL Multi-AZ
- [ ] Instancia: db.r5.xlarge o superior (memory-optimized)
- [ ] Almacenamiento: 500GB mínimo, tipo gp3
- [ ] Multi-AZ: HABILITADO (failover automático)
- [ ] Backup automático: 30 días retención
- [ ] Preferred backup window: 03:00 UTC (fuera pico)
- [ ] Preferred maintenance window: diferente a backup
- [ ] Copy backups to another region: SÍ (disaster recovery)
- [ ] Encryption: KMS (no default AWS key)
- [ ] Storage encryption: HABILITADO
- [ ] Performance Insights: HABILITADO (opcional pero recomendado)

### Seguridad RDS
- [ ] Security group: 5432 SOLO desde SG-app
- [ ] No accesible públicamente (Publicly accessible: NO)
- [ ] IAM authentication: Habilitado
- [ ] Parameter group: max_connections suficiente para ASG
- [ ] Subnet group: Subredes DB privadas en multi-AZ

## Almacenamiento

### S3 Bucket
- [ ] Bucket creado con nombre único (fintech-transactions-prod)
- [ ] Versionado: HABILITADO
- [ ] Encriptación: KMS (no S3-managed)
- [ ] Block public access: TODO bloqueado
- [ ] Bucket policy: Deniega acceso público explícitamente
- [ ] Acceso: SOLO desde VPC Endpoint S3
- [ ] Lifecycle policies:
  - [ ] STANDARD (0-30d)
  - [ ] STANDARD_IA (30-90d)
  - [ ] GLACIER (>90d)
- [ ] MFA delete: Habilitado (si datos críticos)

### S3 Auditoría
- [ ] CloudTrail habilitado (registra PUT, DELETE, GET)
- [ ] Access logs habilitados (quién accedió, cuándo)
- [ ] Server-side encryption: KMS
- [ ] Object tagging: Por tipo de dato (sensitive, public, archive)

## Seguridad & Cumplimiento

### Identidad & Acceso
- [ ] IAM Role para EC2 con permisos mínimos
- [ ] Permisos específicos: S3 GetObject fintech-*
- [ ] Permisos: CloudWatch PutMetricData
- [ ] Permisos: Secrets Manager GetSecretValue
- [ ] NO existe AdminAccess en role (principio menor privilegio)

### Encriptación & Secrets
- [ ] RDS password en Secrets Manager (NO en env vars)
- [ ] Secrets rotation: 30 días automático
- [ ] KMS key: Customer managed (no AWS managed)
- [ ] KMS key rotation: Annual

### Auditoría & Compliance
- [ ] CloudTrail habilitado (todos los API calls)
- [ ] VPC Flow Logs habilitado (tráfico red)
- [ ] AWS Config: EC2, RDS, S3 compliance tracking
- [ ] GuardDuty habilitado (threat detection)
- [ ] CloudWatch Logs centralizados

### PCI-DSS (si aplica)
- [ ] Datos de pago encriptados en tránsito (TLS 1.3)
- [ ] Datos de pago encriptados en reposo (KMS)
- [ ] Acceso a datos de pago auditado (CloudTrail, Logs)
- [ ] Segmentación de red: BD privada, aislada
- [ ] Credenciales rotadas regularmente
- [ ] Penetration testing documentado

## Monitoreo & Alertas

### CloudWatch
- [ ] Dashboard creado (visibilidad operacional)
- [ ] Métricas: ALB (latency, request count, target health)
- [ ] Métricas: ASG (desired, running, terminating instances)
- [ ] Métricas: RDS (CPU, memory, connections, storage)
- [ ] Métricas: S3 (bucket size, object count)
- [ ] Log Groups: ALB logs, RDS logs, app logs

### Alertas SNS
- [ ] ALB target health degraded → SNS notification
- [ ] RDS CPU > 80% → SNS notification
- [ ] ASG scaling event → SNS notification
- [ ] S3 storage > 80% quota → SNS notification
- [ ] RDS disk space < 20% free → SNS notification

## Costo & Optimización

### Análisis de Costo
- [ ] ALB: ~$16/mes
- [ ] EC2 t3.medium (4 promedio): ~$120/mes
- [ ] RDS db.r5.xlarge Multi-AZ: ~$200/mes
- [ ] NAT Gateway (2): ~$64/mes
- [ ] S3: ~$2/mes (100GB)
- [ ] KMS: ~$1/mes
- [ ] Route 53: ~$0.50/mes
- [ ] Data transfer out: ~$50/mes
- **Total estimado**: ~$450/mes (100 usuarios concurrentes)

### Optimización
- [ ] Reserved Instances consideradas (30-40% descuento)
- [ ] Savings Plans evaluados (1 o 3 años)
- [ ] RDS storage optimization (automated minor version upgrades)
- [ ] ASG scaling down en horarios de bajo tráfico (si aplica)
- [ ] S3 lifecycle policies optimizadas

## Alta Disponibilidad

### Redundancia
- [ ] ALB multi-AZ: SÍ (mínimo 2)
- [ ] ASG multi-AZ: SÍ (mínimo 2 instancias en cada AZ)
- [ ] RDS Multi-AZ: SÍ (primary + standby)
- [ ] NAT Gateway por AZ: SÍ (mínimo 2)

### Failover & Recovery
- [ ] RDS failover time: Verificado < 2 minutos
- [ ] Health checks ALB: Verified (respuesta < 3 segundos)
- [ ] AMI backups: Semanales
- [ ] RDS automated backups: 30 días
- [ ] Disaster recovery plan documentado
- [ ] RTO (Recovery Time Objective): < 1 hora
- [ ] RPO (Recovery Point Objective): < 15 minutos

## Documentación

### Runbooks & Guides
- [ ] Architecture diagram documentado (draw.io, Lucidchart)
- [ ] Security groups rules documentadas (qué permite cada uno)
- [ ] Escalado manual runbook (si ASG falla)
- [ ] Database backup & restore procedure documentado
- [ ] Disaster recovery checklist creado
- [ ] Incident response plan existe

### Comunicación
- [ ] Equipos de operaciones entrenad en arquitectura
- [ ] Matriz RACI clara (Responsible, Accountable, Consulted, Informed)
- [ ] Alertas configuradas con contactos

---

## Scoring

**Ítems críticos** (DEBE cumplir):
- Multi-AZ en ALB, ASG, RDS
- Security groups restrictivos
- RDS encriptado & privado
- Backups automáticos habilitados
- Secrets en Secrets Manager
- CloudTrail habilitado

**Ítems importantes** (DEBERÍA cumplir):
- VPC Flow Logs
- GuardDuty
- CloudWatch monitoring
- Lifecycle policies S3

**Ítems opcionales** (PUEDE cumplir):
- Performance Insights RDS
- AWS Config
- Penetration testing

**Pasar**: ≥90% ítems críticos + ≥70% ítems importantes  
**Producción**: ≥95% ítems críticos + ≥90% ítems importantes
