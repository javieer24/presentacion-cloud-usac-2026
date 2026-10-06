# Análisis de Costos - Arquitectura FinTech en AWS

Desglose detallado del costo mensual de una plataforma de procesamiento de pagos escalable en AWS.

## Supuestos Base

| Parámetro | Valor | Notas |
|---|---|---|
| Usuarios concurrentes | 100 | Pico de sesiones simultáneas |
| Transacciones/día | 10,000 | Volumen diario de pagos |
| Almacenamiento datos | 100 GB/mes | Histórico + auditoría |
| Data transfer out | 5 TB/mes | Salida a partners, reportes |
| Uptime SLA | 99.99% | 4 nines = máx 52 min downtime/año |
| Región | us-east-1 | N. Virginia (más barato) |

## Cómputo

### Application Load Balancer (ALB)
```
Componente: ALB
Cantidad: 1 (distribuye tráfico multi-AZ)
Horas/mes: 730 horas
Costo ALB: $16.00/mes
Costo data processing: <$1 (negligible para 100 usuarios)
```

**Desglose**:
- Nuevo ALB: $0.0225/hora → $16.43/mes
- Regla adicional: $1 → incluida
- Capacidad de unidad (LCU): $5.00 → negligible con 100 usuarios

**Total ALB**: ~$16/mes

### Auto Scaling Group (EC2)

**Configuración**:
- Instancia: t3.medium (2 vCPU, 4 GB RAM)
- Min: 2, Max: 20, Promedio esperado: 4 (2 pico, 2 valle)
- Precio t3.medium: $0.0416/hora (on-demand, us-east-1)

```
Promedio instancias: 4
Horas/mes: 730
Costo: 4 × 730 × $0.0416 = $121.40

Almacenamiento (EBS gp3): 30 GB × $0.10/GB = $3/mes
  (snapshots negligibles)

Total EC2/ASG: ~$124/mes
```

**Escalado dinámico** (proyección):
- 100 usuarios → 4 instancias
- 500K usuarios → ~20 instancias ($620/mes)
- 1M usuarios → ~40 instancias ($1,240/mes)

## Redes

### NAT Gateway

**Requisito**: 1 NAT Gateway por AZ (para redundancia)

```
NAT Gateway AZ-a: $0.045/hora → $32.85/mes
NAT Gateway AZ-b: $0.045/hora → $32.85/mes
  
Data processing (salida): 5 TB/mes × $0.045/GB = $230/mes
  (costo de NAT gateway por GB transferido)

Total NAT Gateway: $296/mes

Optimización: Usar VPC Endpoint S3 (gratis vs $230/mes)
  → Reducción a: $65/mes
```

**Recomendación**: Implementar VPC Endpoint S3 (reduce ~$230/mes)

### Internet Gateway
- Costo: $0 (incluido)

### VPC & Subredes
- Costo: $0 (incluido)

### Route 53 (DNS)
```
Hosted zones: 1 × $0.50/mes = $0.50
Queries: 10M/mes × $0.40 per million = $4/mes
Health checks: 1 × $0.50/mes = $0.50

Total Route 53: ~$5/mes
```

**Total Networking**: ~$70/mes (sin optimización) → ~$5/mes (con VPC Endpoint)

## Base de Datos

### RDS PostgreSQL Multi-AZ

**Instancia Principal**:
- Tipo: db.r5.xlarge (4 vCPU, 32 GB RAM)
- Precio: $1.126/hora (on-demand, Multi-AZ doubles)
- Horas/mes: 730
- Costo: 730 × $1.126 × 2 = $1,642/mes

**Almacenamiento**:
- 500 GB gp3 SSD
- Costo: 500 × $0.20 = $100/mes
- Backups: 500 GB × $0.10 = $50/mes

**I/O Operations** (variable):
- Provisional: 3,000 IOPS × $0.15/IOPS = $450/mes (gp3 incluye)
- Throughput: 125 MB/s (gp3 estándar, incluido)

**Encriptación KMS**:
- 1 customer managed key
- Costo: $1/mes (10,000 requests/mes incluidos)

```
Total RDS Multi-AZ: $1,642 + $100 + $50 + $1 = $1,793/mes
```

**Optimizaciones**:
- Reserved Instance (1 año): -40% → $1,075/mes
- Reserved Instance (3 años): -50% → $896/mes
- Read replicas para reportes: +$400/mes (ej: Redshift)

## Almacenamiento

### S3 Bucket

**Almacenamiento**:
```
100 GB/mes promedio (transacciones históricas)
Costo STANDARD: 100 × $0.023/GB = $2.30

Costo STANDARD_IA (archivos >30 días): Negligible
```

**Transferencia de datos**:
```
Entrada (PUT):
  10,000 transacciones × 1 KB = 10 GB/mes
  Costo: Gratis (no hay costo de ingreso)

Salida (GET):
  5 TB/mes × $0.09/GB = $450/mes
  (excepto si via NAT Gateway vía VPC Endpoint = gratis)
```

**Solicitudes API**:
```
PUT: 10,000 transacciones = negligible (<$1)
GET: 100,000 queries = negligible (<$1)
```

**Versionado & Lifecycle**:
```
Versiones previas: ~20 GB × $0.023 = $0.46
Lifecycle (GLACIER): Negligible después 90d
```

```
Total S3: $2.30 + $450 (transfer) = $452.30/mes
  CON VPC Endpoint: $2.30/mes (transfer gratis)
```

## Servicios Adicionales

### CloudWatch Logs
```
CloudWatch Agent en EC2:
  Logs generados: ~1 GB/mes
  Costo: $0.50/GB → $0.50/mes

ALB Access Logs:
  ~100 MB/mes × $0.50/GB → $0.05/mes

RDS Enhanced Monitoring:
  1 DB × $9/mes = $9/mes

Total CloudWatch: ~$10/mes
```

### AWS Secrets Manager
```
1 secret (RDS password)
Costo: $0.40 + rotación automática
Total: $0.40/mes
```

### CloudTrail (Auditoría)
```
1-2 GB de logs/mes
Costo: $2/mes (primero 100K eventos gratis)
```

### AWS Config (Compliance)
```
Evaluaciones de recursos: ~20 recursos
Costo: $3/mes
```

### GuardDuty (Threat Detection)
```
Análisis de logs CloudTrail:
Costo: $12/mes (primeros 2TB VPC Flow Logs gratis)
```

```
Total Servicios Adicionales: ~$28/mes
```

## Resumen por Categoría

| Categoría | Componente | Costo/mes | Notas |
|---|---|---|---|
| **CÓMPUTO** | ALB | $16 | |
| | EC2 (ASG) | $124 | t3.medium x4 promedio |
| | **Subtotal** | **$140** | |
| **REDES** | NAT Gateway | $296 | SIN VPC Endpoint |
| | Route 53 | $5 | |
| | | ($65) | CON VPC Endpoint (recomendado) |
| | **Subtotal** | **$301** | **$70 optimizado** |
| **BASE DE DATOS** | RDS Multi-AZ | $1,793 | db.r5.xlarge, backup, encriptación |
| | **Subtotal** | **$1,793** | |
| **ALMACENAMIENTO** | S3 | $452 | CON transferencia data; $2.30 CON VPC Endpoint |
| | **Subtotal** | **$452** | **$2.30 optimizado** |
| **SERVICIOS** | CloudWatch, Secrets, CloudTrail, etc | $28 | Monitoreo y auditoría |
| | **Subtotal** | **$28** | |
| | | | |
| **TOTAL MENSUAL** | | **$2,714** | SIN optimizar |
| | | **$2,033** | CON VPC Endpoint + optimizaciones |

## Escenarios de Crecimiento

### Escenario 1: 100 Usuarios Concurrentes (ACTUAL)
```
ASG: 2-4 instancias = $124/mes
RDS: 1 db.r5.xlarge = $1,793/mes
Total: ~$2,033/mes (optimizado)
```

### Escenario 2: 500K Usuarios Concurrentes (10x)
```
ASG: 10-15 instancias = $310/mes
RDS: 2 × db.r5.xlarge (read replica) = $3,586/mes
Data transfer: ~$1,500/mes
Total: ~$5,396/mes

→ Pasar a db.r7g (Graviton, -30%): $3,910/mes
→ Total optimizado: ~$4,720/mes
```

### Escenario 3: 1M Usuarios Concurrentes (100x)
```
ASG: 20-30 instancias = $620/mes
RDS: Aurora PostgreSQL cluster = $5,000+/mes
Data transfer: ~$4,500/mes
Global acceleration (multi-región): $2,000/mes
Total: ~$12,000+/mes

→ Considerar: Reserved Instances (-40%), Aurora Global Database,
   CloudFront para static content
```

## Optimizaciones Recomendadas

| Optimización | Ahorro/mes | Complejidad | Prioridad |
|---|---|---|---|
| VPC Endpoint S3 | $230 | Baja | 🔴 ALTA |
| Reserved Instances (1 año) | $719 | Baja | 🔴 ALTA |
| RDS Read Replica para reportes | +$400 | Media | 🟡 MEDIA |
| Aurora (vs RDS) | +$200 | Alta | 🟢 BAJA |
| CloudFront CDN | Variable | Media | 🟢 BAJA |
| S3 Intelligent-Tiering | $5-10 | Baja | 🟡 MEDIA |

## Proyección Anual

| Mes | Usuarios | Costo/mes | Costo Acumulado |
|---|---|---|---|
| 1-3 | 100 | $2,033 | $6,099 |
| 4-6 | 500 | $2,150 | $12,549 |
| 7-9 | 5,000 | $2,400 | $19,749 |
| 10-12 | 50,000 | $3,200 | $32,549 |

**Costo anual estimado**: $32,500 para crecimiento 100 → 50,000 usuarios

## Comparativa: AWS vs On-Premise

| Aspecto | AWS Cloud | On-Premise | Winner |
|---|---|---|---|
| Costo inicial | $0 | $500,000 | ☁️ AWS |
| Año 1 | $24,396 | $50,000 (amortizado) | ☁️ AWS |
| Año 3 | $73,188 | $50,000 (amortizado) | 🏢 On-Premise |
| Escalabilidad | 10-1,000x | 2-5x | ☁️ AWS |
| Disponibilidad | 99.99% | 99.9% | ☁️ AWS |
| Mantenimiento | AWS responsable | Cliente responsable | ☁️ AWS |

**Conclusión**: AWS es ventajoso para startups y crecimiento rápido. On-Premise para grandes empresas con usuarios estables.

---

**Notas importantes**:
- Precios basados en us-east-1 (región más barata)
- Sujetos a cambios según políticas AWS
- Free tier no considerado (excepto primeros 12 meses)
- Datos de 2026 Q4, actualizar anualmente
