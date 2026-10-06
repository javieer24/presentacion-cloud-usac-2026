# Glosario Técnico - Ecosistema Cloud

## A

**Availability Zone (AZ)**  
Datacenter aislado geográficamente dentro de una región AWS. Cada AZ tiene alimentación, refrigeración y red redundantes. Si una AZ falla, las otras mantienen servicio. Ejemplo: us-east-1a, us-east-1b, us-east-1c en la región us-east-1.

**Auto Scaling Group (ASG)**  
Grupo de instancias EC2 que escala automáticamente basado en métricas. Mantiene un número mínimo y máximo de instancias. Escala UP si CPU > 70%, escala DOWN si CPU < 30%.

## C

**CAPEX (Capital Expenditure)**  
Inversión inicial en infraestructura física (servidores, cables, racks). Modelo antiguo: comprar $100K en hardware que dura 5 años.

**CIDR Block**  
Notación para definir un rango de direcciones IP. Ejemplo: 10.0.0.0/16 = 65,536 direcciones IP disponibles (10.0.0.0 hasta 10.0.255.255).

**Cloud Computing**  
Provisión de recursos IT (cómputo, almacenamiento, redes) bajo demanda a través de internet, pagando solo por consumo.

**Compliance (Cumplimiento)**  
Adherencia a regulaciones y estándares legales. Ejemplos: PCI-DSS (datos de pago), HIPAA (datos médicos), GDPR (datos personales Europa).

## D

**Direct Connect**  
Conexión dedicada privada entre datacenter on-premise y AWS. No pasa por internet público. Velocidades: 1 Gbps, 10 Gbps, 100 Gbps.

## E

**EC2 (Elastic Compute Cloud)**  
Máquinas virtuales escalables en AWS. Tipos: t3 (general), m5 (balanceado), c5 (optimizado CPU), r5 (optimizado memoria).

**EBS (Elastic Block Store)**  
Almacenamiento en bloque persistente para EC2. Tipos: gp3 (general, recomendado), io2 (ultra-alto rendimiento).

**Elasticidad**  
Capacidad de escalar recursos UP (más instancias) o DOWN (menos instancias) automáticamente según demanda.

**ELB/ALB (Elastic Load Balancer / Application Load Balancer)**  
Distribuye tráfico entrante entre múltiples instancias. ALB = Layer 7 (aplicación), NLB = Layer 4 (transporte, ultra-performance).

**Endpoint (VPC Endpoint)**  
Conexión privada a servicios AWS sin pasar por internet. Gateway Endpoints (S3, DynamoDB), Interface Endpoints (otros servicios).

## F

**Failover**  
Cambio automático del componente primary a standby cuando primary falla. Ej: RDS Multi-AZ failover < 2 minutos.

**Firewall**  
Control de tráfico (permite/bloquea puertos). En AWS: Security Groups (stateful, por instancia), NACLs (stateless, por subred), WAF (web).

## H

**HA (High Availability)**  
Diseño para máxima disponibilidad. SLA 99.99% = máximo 52 minutos downtime/año. Requiere Multi-AZ redundancia.

**Hybrid Cloud**  
Mezcla de infraestructura privada (on-premise) + nube pública (AWS). Conectadas via Direct Connect o VPN.

## I

**IaaS (Infrastructure as a Service)**  
Proveedor gestiona hardware/red, cliente gestiona SO/aplicación/datos. Ejemplo: AWS EC2.

**IGW (Internet Gateway)**  
Puerta entre VPC e internet. Permite acceso público a instancias en subredes públicas.

**IAM (Identity and Access Management)**  
Gestión de usuarios, roles, permisos en AWS. Define quién puede hacer qué en qué recursos.

## K

**KMS (Key Management Service)**  
Servión de gestión de claves de encriptación. Cifra datos en reposo. Rotación automática de master keys.

## L

**Load Balancer**  
Ver ELB/ALB.

## M

**Multi-AZ**  
Arquitectura distribuida en múltiples Availability Zones. Si una AZ falla, servicio continúa en otras.

**Multi-región**  
Distribuir aplicación en múltiples regiones AWS (us-east-1, eu-west-1, ap-southeast-1). Máxima redundancia y latencia baja global.

## N

**NACL (Network Access Control List)**  
Firewall stateless a nivel de subred. Permite/bloquea tráfico entrada y salida. Menos usado que Security Groups.

**NAT Gateway**  
Permite que instancias privadas accedan internet saliente (no entrante). Requiere IP pública. Costo: ~$32/mes.

**Nube Híbrida**  
Ver Hybrid Cloud.

**Nube Privada**  
Infraestructura exclusiva (on-premise o dedicada). Control total, costo alto, escalabilidad limitada.

**Nube Pública**  
Infraestructura compartida entre miles de clientes (AWS, Azure, GCP). Bajo costo, escalabilidad masiva.

## O

**OPEX (Operational Expenditure)**  
Gastos operativos pagados por consumo. Modelo cloud: paga $500/mes solo por lo que usas.

**Orquestación**  
Automatización de flujos de trabajo. Ejemplo: ECS/EKS (Docker containers), Kubernetes (K8s).

## P

**PaaS (Platform as a Service)**  
Proveedor gestiona hasta runtime, cliente gestiona aplicación. Ejemplo: AWS Elastic Beanstalk, Heroku.

**PCI-DSS (Payment Card Industry Data Security Standard)**  
Estándar de cumplimiento para datos de tarjetas de crédito. Requiere encriptación, auditoría, segmentación de red.

**Peering (VPC Peering)**  
Conexión 1-a-1 entre dos VPCs. Tráfico privado, no por internet.

## R

**RDS (Relational Database Service)**  
Bases de datos gestionadas (MySQL, PostgreSQL, MariaDB, Oracle). Multi-AZ disponible para failover automático.

**Region**  
Área geográfica con múltiples AZs (us-east-1, eu-west-1, ap-southeast-1). Latencia baja para usuarios cercanos.

**Route Table**  
Reglas que determinan a dónde va el tráfico. Asociada a subredes. Ruta más específica gana.

## S

**S3 (Simple Storage Service)**  
Almacenamiento de objetos infinitamente escalable. Buckets, versionado, encriptación, lifecycle policies.

**SaaS (Software as a Service)**  
Proveedor gestiona TODO, cliente solo usa. Ejemplo: Salesforce, Microsoft 365, Slack.

**Scalability (Escalabilidad)**  
Capacidad de soportar crecimiento (10 → 10,000 usuarios) sin rediseño arquitectónico.

**Security Group**  
Firewall stateful a nivel de instancia. Permite/bloquea puertos entrada y salida. Más usado que NACL.

**Serverless**  
Cómputo sin gestionar servidores (AWS Lambda). Paga solo por ejecución (100ms). Auto-scaling.

**SLA (Service Level Agreement)**  
Contrato de disponibilidad. Ejemplo: 99.99% = máximo 52 min downtime/año.

**Stateful**  
Si permite salida, entrada vuelve automáticamente. Security Groups son stateful.

**Stateless**  
Debe permitir entrada Y salida explícitamente. NACLs son stateless.

**Subnet**  
Subdivisión de VPC. Cada subnet = una AZ. Puede ser pública (acceso internet) o privada.

## T

**Transit Gateway**  
Hub central que conecta múltiples VPCs + on-premise. Topología Hub-and-Spoke. Transitivo (A→TGW→B→C visible).

**Tier**  
Capa de arquitectura. Tier 1 = Frontend, Tier 2 = Aplicación, Tier 3 = Base de Datos.

## V

**VPC (Virtual Private Cloud)**  
Red privada aislada en AWS. CIDR Block define rango IPs. Contiene subredes, IGW, route tables.

**VPC Endpoint**  
Acceso privado a servicios AWS sin pasar por internet. Gateway (S3, DynamoDB), Interface (otros).

**VPN (Virtual Private Network)**  
Encriptación por internet público. Más lenta que Direct Connect, más barata, para conexiones temporales.

## W

**WAF (Web Application Firewall)**  
Protección de aplicaciones web contra ataques (SQL Injection, XSS, DDoS). En ALB o CloudFront.

## Z

**Zero Trust**  
Principio de seguridad: no confiar en nadie por defecto. Toda conexión requiere autenticación/autorización, incluso dentro red.

---

**Notas**:
- Términos ordenados alfabéticamente para referencia rápida
- Énfasis en conceptos AWS (no Azure/GCP equivalentes en este glosario)
- Incluye ejemplos prácticos y contexto de uso
