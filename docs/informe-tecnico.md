# Informe Técnico - Ecosistema Cloud 2026

Resumen ejecutivo y apuntes técnicos de la presentación "Ecosistema Cloud 2026" para USAC - Facultad de Ingeniería.

---

## Introducción

Cloud Computing es la provisión de recursos IT bajo demanda a través de internet. El cambio paradigmático clave es:
- **CAPEX (antes)**: Inversión de $100K en infraestructura física por 5 años
- **OPEX (ahora)**: Pago de $500/mes por uso real

---

## Características Fundamentales de Cloud

1. **Computación bajo Demanda**: Acceso inmediato a vCPUs, RAM, storage
2. **Disponibilidad Global**: Acceso desde cualquier parte, baja latencia
3. **Alta Escalabilidad**: De 1 a 10,000 usuarios sin rediseño
4. **Elasticidad**: Escala automática, recursos se liberan al bajar demanda
5. **Modelo Gestionado**: Proveedor gestiona hardware/red, tú innovas
6. **Pay-as-you-go**: Facturación al consumo, sin costos fijos
7. **Automatización**: Provisión sin intervención manual (IaC)

---

## Modelos de Despliegue

### Nube Pública
- Infraestructura compartida (miles de clientes)
- Proveedores: AWS, Azure, GCP
- **Ventajas**: Escalabilidad extrema, bajo costo, cero mantenimiento
- **Desventajas**: Menor control, cumplimiento complejo
- **Caso**: Startups, aplicaciones escalables

### Nube Privada
- Infraestructura exclusiva single-tenant
- On-premise, Hosted, AWS Outposts
- **Ventajas**: Control total, cumplimiento garantizado
- **Desventajas**: Costo muy alto, mantenimiento complejo
- **Caso**: Bancos, hospitales, gobiernos

### Nube Híbrida
- Mezcla privada (datos sensibles) + pública (apps escalables)
- Conectada via Direct Connect, VPN, Storage Gateway
- **Caso**: Migración gradual, datos regulados on-premise + apps en AWS

### Multinube
- Uso estratégico AWS + Azure + GCP
- Evita vendor lock-in
- Complejidad X3 en gobernanza
- **Caso**: Empresas Fortune 500

---

## Modelos de Servicio

### IaaS - Infraestructura como Servicio
**Proveedor gestiona**: Hardware, red, virtualización  
**Cliente gestiona**: SO, aplicación, datos, runtime

Ejemplo: AWS EC2
- Máximo control, máxima flexibilidad
- Máxima responsabilidad

### PaaS - Plataforma como Servicio
**Proveedor gestiona**: Hardware, red, SO, runtime  
**Cliente gestiona**: Aplicación, datos

Ejemplo: AWS Elastic Beanstalk
- Desarrollo rápido, escalabilidad automática
- Menos flexible (solo lenguajes soportados)

### SaaS - Software como Servicio
**Proveedor gestiona**: TODO  
**Cliente**: Solo usa

Ejemplos: Salesforce, Microsoft 365, Slack, Gmail
- Cero instalación, bajo mantenimiento
- Poco control, seguridad en manos del proveedor

---

## Comparativa Multicloud 2026

### AWS (32% mercado, $45B+)
- 200+ servicios (mayor catálogo)
- Documentación mejor
- Comunidad más grande
- **Fortaleza**: Innovación rápida, 1 servicio cada 3 días
- **Debilidad**: Complejidad, pricing opaco
- **Caso**: Netflix S3 (100M+ usuarios), la mayoría startups

### Azure (20% mercado, $30B+)
- Integración Microsoft ecosystem profunda
- Compliance fuerte (HIPAA, GDPR, FedRAMP)
- Híbrida nativa (Azure Arc)
- **Caso**: Bancos, empresas Microsoft 365

### GCP (15% mercado, $10B+, 82% crecimiento YoY)
- BigQuery (analytics masivo sin ops)
- ML nativa (modelos pre-entrenados)
- Infraestructura robusta
- **Caso**: Empresas de datos, analytics a escala

### Tabla de Equivalencias

| Necesidad | AWS | Azure | GCP |
|---|---|---|---|
| Máquina virtual | EC2 | Virtual Machine | Compute Engine |
| Contenedores | EKS | AKS | GKE |
| Serverless | Lambda | Functions | Cloud Functions |
| Object Storage | S3 | Blob Storage | Cloud Storage |
| SQL Database | RDS | SQL Database | Cloud SQL |
| NoSQL | DynamoDB | Cosmos DB | Firestore |
| Load Balancer | ALB | Load Balancer | Cloud LB |

---

## Arquitectura de Redes AWS

### VPC (Virtual Private Cloud)
Tu red privada aislada en AWS. Componentes:
- **CIDR Block**: Rango de IPs (ej: 10.0.0.0/16 = 65,536 IPs)
- **Availability Zones (AZs)**: Data centers aislados
  - us-east-1a, us-east-1b, us-east-1c (50km de distancia)
  - Si 1 AZ falla, otros 2 quedan en pie

### Subredes
Divisiones de VPC, cada una en **una sola AZ**:
```
VPC 10.0.0.0/16
├─ Subnet Pública AZ-a: 10.0.1.0/24 (256 IPs)
├─ Subnet Pública AZ-b: 10.0.2.0/24 (256 IPs)
├─ Subnet Privada AZ-a: 10.0.10.0/24
└─ Subnet Privada AZ-b: 10.0.11.0/24
```

### Subred Pública vs Privada

**Pública**:
- Ruta a Internet Gateway
- Instancias reciben IP pública
- Accesible desde internet

**Privada**:
- NO ruta directa a IGW
- Instancias NO reciben IP pública
- Accesibles solo desde dentro VPC
- Para salir a internet: NAT Gateway

**Regla de oro**:
- Frontend, ALB, bastion → Subnets públicas
- Apps, BD, datos → Subnets privadas

### Internet Gateway (IGW)
- Puerta entre VPC ↔ Internet
- 1 por VPC (compartido)
- Costo: Gratis

### NAT Gateway
- Permite EC2 privadas acceder SALIENTE a internet
- Ubicación: DEBE estar en subnet pública
- Traducción: IP privada 10.0.10.5 → IP pública temporal
- **CRÍTICO**: 1 NAT por AZ (redundancia)
- Costo: ~$32 USD/mes por AZ

### Security Groups
Firewall a nivel de instancia. **Stateful** (respuestas automáticas).

**Ejemplo inbound**:
```
Puerto | Protocolo | Fuente | Acción
80     | TCP       | 0.0.0.0/0 | ALLOW (HTTP público)
443    | TCP       | 0.0.0.0/0 | ALLOW (HTTPS público)
22     | TCP       | 203.0.113.0/24 | ALLOW (SSH admin)
3306   | TCP       | sg-app | ALLOW (MySQL desde app)
---    | --- | --- | DENY (default)
```

**Clave**: Si no dices SÍ, es NO (default deny inbound).

**Mejor práctica**:
- ALB: 443 desde 0.0.0.0/0 (usuarios)
- ASG: 8080 SOLO desde SG del ALB
- RDS: 5432 SOLO desde SG de app

### NACLs (Network Access Control Lists)
- Firewall a nivel de **SUBRED** (no instancia)
- **Stateless** (debes permitir ENTRADA y SALIDA)
- Raramente necesarias (SGs suelen ser suficientes)

### Route Tables
Reglas que determinan a dónde va el tráfico.

Estructura:
```
Destino CIDR      | Target
10.0.0.0/16       | Local (dentro VPC)
192.168.0.0/16    | pcx-xxxxx (peering otra VPC)
0.0.0.0/0         | igw-xxxxx (internet)
```

Evaluación: **Ruta MÁS ESPECÍFICA gana**.

---

## Caso Práctico: Arquitectura FinTech

**Escenario**: Plataforma de procesamiento de pagos
- 100K-1M usuarios simultáneos
- Datos regulados (PCI-DSS) → Máxima seguridad
- SLA 99.99% (máximo 52 minutos downtime/año)

### Arquitectura General

```
INTERNET (Usuario paga)
    ↓ HTTPS:443
Route 53 (DNS failover)
    ↓
ALB + WAF (Subred Pública AZ-a, AZ-b)
    ↓
ASG (Auto Scaling Group, Subred Privada AZ-a, AZ-b)
    ↓
RDS PostgreSQL Multi-AZ (Subred DB AZ-a, AZ-b con failover)
    ↓
S3 + KMS (Transacciones encriptadas)
```

**VPC**: 10.0.0.0/16
- Subnets Públicas: 10.0.1.0/24 (AZ-a), 10.0.2.0/24 (AZ-b)
- Subnets App: 10.0.10.0/24 (AZ-a), 10.0.11.0/24 (AZ-b)
- Subnets DB: 10.0.20.0/24 (AZ-a), 10.0.21.0/24 (AZ-b)

### Tier 1: Frontend Público

**Application Load Balancer (ALB)**:
- Distribuye tráfico entre múltiples instancias
- IP pública elástica: 203.0.113.1
- Puerto 443 (HTTPS)
- Health checks cada 30s

**AWS WAF**:
- Bloquea ataques web (SQL Injection, XSS, DDoS)
- Rate limiting: 100 requests/min por IP
- OWASP Top 10 rules activadas

**NAT Gateway** (1 por AZ):
- AZ-a: nat-xxxxx en 10.0.1.0/24
- AZ-b: nat-xxxxx en 10.0.2.0/24
- Costo: ~$64/mes (2 × $32)

### Tier 2: Lógica de Negocio

**Auto Scaling Group (ASG)**:
- EC2 t3.medium (2 vCPU, 4GB RAM)
- Ubuntu 20.04 + Node.js
- Puerto 8080 (aplicación)
- Min: 2, Max: 20, Target CPU: 70%

**Escalado automático**:
- CPU 75% → Agregar 2 instancias
- 100K usuarios → ~5 instancias
- 1M usuarios → ~20 instancias
- CPU 30% → Remover instancias

**Punto de seguridad**: ASG NO en subnet pública. Usuario no ve sus IPs. ALB es único gateway.

### Tier 3: Base de Datos

**RDS PostgreSQL Multi-AZ**:
- Instancia: db.r5.xlarge (4 vCPU, 32GB RAM)
- Almacenamiento: 500GB gp3
- Backup automático: Diarios, 30 días retención
- Failover automático: <2 minutos

**Multi-AZ arquitectura**:
- Primary (AZ-a): Recibe writes
- Standby (AZ-b): Sincronización síncrona
- Si Primary falla: Failover automático

**Encriptación**:
- En tránsito: SSL/TLS por defecto
- En reposo: KMS (AWS managed key)

### Tier 4: Almacenamiento

**S3 Bucket: fintech-transactions-prod**:
- Almacenamiento historial transacciones
- Acceso: Privado (VPC Endpoint S3)
- Versionado: Habilitado
- Encriptación: KMS
- Lifecycle:
  - STANDARD (0-30d) → Hot
  - STANDARD_IA (30-90d) → Warm
  - GLACIER (>90d) → Cold

**CloudTrail**: Auditoría de todos accesos S3

**Costo**: 100GB/mes × $0.023/GB = $2.30/mes

### Flujo de Tráfico: Usuario realiza pago

**1. Cliente → ALB (HTTPS)**:
```
Cliente (203.0.113.10) HTTPS:443
  ↓ Route 53 DNS
ALB IP pública (203.0.113.1)
  ↓ Desencripta HTTPS → HTTP:8080 interno
ALB balancea entre AZ-a, AZ-b
  ↓
ASG EC2-a (10.0.10.50) O ASG EC2-b (10.0.11.50)
```

**2. App → Base de Datos (TCP:5432)**:
```
EC2-a (10.0.10.50) procesa transacción
  ↓ Conecta RDS PostgreSQL
RDS Primary (10.0.20.100)
  ↓ Sincronización síncrona a Standby (10.0.21.100)
  ↓ Commit confirmado a EC2
```

**3. App → Internet (NAT)**:
```
EC2-a (10.0.10.50) llama MercadoPago API
  ↓ NAT Gateway traduce: 10.0.10.50 → 203.0.113.10
  ↓ Paquete sale a internet
  ↓ Respuesta vuelve NAT → EC2-a
```

**4. App → S3 (VPC Endpoint)**:
```
EC2-a (10.0.10.50) archiva transacción
  ↓ VPC Endpoint S3 (privado, ruta en route table)
  ↓ NO sale a internet (conexión privada AWS-interna)
S3 Bucket fintech-transactions-prod
```

### Seguridad Multicapa

1. **WAF en ALB**: Bloquea ataques web (SQLi, XSS, DDoS)
2. **Security Groups**: Segmentación por componente
3. **Encriptación**: TLS 1.3 (tránsito) + KMS (reposo)
4. **Auditoría**: CloudTrail, VPC Flow Logs, CloudWatch Logs
5. **Gestión de Secretos**: AWS Secrets Manager (rotación automática 30d)

**Resultado**: Si 1 EC2 es comprometida, atacante no puede:
- Acceder a RDS (SG bloquea)
- Acceder a otra EC2 (aisladas)
- Salir a internet sin ser detectado (NAT logs)

---

## Costo Mensual Estimado (FinTech 100 usuarios)

| Componente | Costo |
|---|---|
| ALB | $16 |
| EC2 (5 instancias t3.medium) | $120 |
| RDS (db.r5.xlarge) | $200 |
| NAT Gateway (2×) | $64 |
| S3 (100GB) | $2.30 |
| **TOTAL** | **~$450/mes** |

Escala a 1M usuarios: ~$4,500/mes (10x recursos, 10x costo)

---

## Principios del Arquitecto Cloud

1. **Diseña para fallar**: Asume que componentes fallarán
2. **Automatiza para escalar**: Crecimiento sin intervención manual
3. **Monitorea para decidir**: Observabilidad en tiempo real

---

## Recursos Adicionales

- Documentación oficial AWS: https://docs.aws.amazon.com/
- AWS Well-Architected Framework: https://aws.amazon.com/architecture/well-architected/
- Certificación SAA-C03: https://aws.amazon.com/certification/certified-solutions-architect-associate/
- A Cloud Guru cursos: https://acloudguru.com/

---

**Autor**: Javier Andrés Monjes Solórzano  
**Especialidad**: Cloud Security, AWS Architecture  
**Fecha**: Octubre 2026
