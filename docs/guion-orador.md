# Guión del Orador - Ecosistema Cloud 2026

## Timings por Sección (100 minutos total)

| Sección | Duración | Tiempo Acumulado | Notas |
|---|---|---|---|
| 1. Intro + Presentador | 5 min | 0:05 | Tu presentación personal |
| 2. ¿Qué es Cloud Computing? | 5 min | 0:10 | Conceptos fundadores |
| 3. Modelos Despliegue | 7 min | 0:17 | Pública, Privada, Híbrida |
| 4. IaaS/PaaS/SaaS | 8 min | 0:25 | Tablas de responsabilidad |
| 5. Comparativa Multicloud | 10 min | 0:35 | AWS vs Azure vs GCP |
| 6. Arquitectura Redes AWS | 15 min | 0:50 | VPC, Security Groups (CRÍTICA) |
| 7. Caso Práctico FinTech | 20 min | 1:10 | Arquitectura completa (PRINCIPAL) |
| 8. Conexión Híbrida | 5 min | 1:15 | Direct Connect, On-premise |
| 9. Conclusiones + Q&A | 15 min | 1:30 | Buffer y preguntas |

---

## PRESENTADOR (5 min: 0:00 - 0:05)

**Slide 1-2: Portada**

"Buenos días, mi nombre es **Javier Andrés Monjes Solórzano**. Soy SOC Analyst y Blue Team Consultant con especialidad en Seguridad Cloud en AWS. 

Durante los próximos 100 minutos, vamos a recorrer el **Ecosistema Cloud 2026** desde cero: partimos desde la pregunta fundamental '¿Qué es Cloud Computing?' y terminamos implementando una arquitectura real de FinTech con alta disponibilidad y seguridad multicapa en AWS.

Mi rol aquí es que entiendas **no solo CÓMO** funcionan los servicios cloud, sino **POR QUÉ** están diseñados así. Esto es crítico para ser un arquitecto confiable."

**Puntos a enfatizar**:
- Experiencia en: Threat Monitoring, Incident Response, Digital Forensics
- Herramientas: EDR/XDR, IDS/IPS, Firewalls, Email Security
- Enfoque: Seguridad desde el diseño (Zero Trust)

---

## ¿QUÉ ES CLOUD COMPUTING? (5 min: 0:05 - 0:10)

**Slides 3-4**

"Cloud Computing es la provisión de recursos IT **bajo demanda**, a través de internet. No compras servidores físicos; los rentas por el tiempo que los usas.

El cambio de paradigma clave: **CAPEX → OPEX**
- Antes (CAPEX): Invertías $100,000 en infraestructura física que duraba 5 años
- Ahora (OPEX): Pagas $500/mes por uso real, solo pagas lo que consumes

Las 7 características fundamentales de Cloud:

1. **Computación bajo Demanda**: Acceso inmediato a recursos vCPUs, RAM
2. **Disponibilidad Global**: Acceso desde cualquier parte del mundo, baja latencia
3. **Alta Escalabilidad**: De 1 a 10,000 usuarios sin rediseño arquitectónico
4. **Elasticidad**: Escala automática, si la demanda cae, los recursos se liberan
5. **Modelo Gestionado**: El proveedor gestiona hardware/red, tú te enfocas en innovar
6. **Pay-as-you-go**: Facturación al consumo, no hay costos fijos
7. **Automatización**: Provisión sin intervención manual, IaC"

---

## MODELOS DE DESPLIEGUE (7 min: 0:10 - 0:17)

**Slides 5-8**

### Nube Pública (2 min)

"**Nube Pública**: Infraestructura **compartida** entre miles de clientes. 

Proveedores: AWS, Microsoft Azure, Google Cloud.

Ejemplos reales: Netflix usa AWS S3 (almacenamiento compartido), la mayoría de startups.

**Ventajas**:
- Escalabilidad extrema (Netflix tiene millones de usuarios simultáneos)
- Bajo costo inicial
- Mantenimiento cero (AWS actualiza servidores, no tú)
- Innovación rápida (AWS saca 100+ servicios nuevos al año)

**Desventajas**:
- Menor control absoluto (compartes hardware con otros clientes)
- Cumplimiento normativo más complejo
- Seguridad compartida (AWS gestiona infraestructura física; tú la red)

**Pausa**: ¿Preguntas hasta aquí? No es para cuestionar, es para asimilar."

### Nube Privada (2 min)

"**Nube Privada**: Infraestructura **exclusiva**, single-tenant.

Tipos: On-premise (tu data center), Hosted (servidor dedicado en cloud), AWS Outposts (cloud AWS en tu datacenter).

Ejemplos: Bancos, hospitales, gobiernos (datos ultra-regulados).

**Ventajas**:
- Control total
- Cumplimiento garantizado (tú controlas acceso, cifrado, auditoría)
- Seguridad máxima

**Desventajas**:
- Costo muy alto ($1M+ en setup)
- Mantenimiento complejo (tú pagas el 24/7)
- Escalabilidad limitada (capacidad física fija)

**Pregunta de reflexión**: ¿Un banco usaría nube pública? No, datos de clientes = regulado. Excepción: datos NO regulados → AWS público."

### Nube Híbrida (2 min)

"**Nube Híbrida**: Mezcla de privada (datos sensibles on-premise) + pública (aplicaciones escalables en AWS).

Conectada via:
- AWS Direct Connect (línea dedicada privada)
- VPN (encriptación por internet)
- Storage Gateway (puente entre on-premise y S3)

**Caso real**: Migración gradual. El banco mantiene DB de clientes on-premise (regulado) pero mueve reporting a AWS Athena (escalable).

**Desafíos**:
- Complejidad de red aumenta (dos mundos conectados)
- Latencia variable (datos viajen, pero por red privada)
- Gobernanza multicapa (¿Cuál infra? ¿Cuál cloud?)"

### Multinube (1 min)

"**Multinube**: Uso estratégico de AWS + Azure + GCP

Por qué: Evitar vendor lock-in. AWS es mejor para procesamiento; GCP para ML; Azure si usas Microsoft 365.

**Mercado 2026**: 
- AWS 32% + Azure 20% + GCP 15% = 63% dominan el mercado
- Pero más allá: Oracle Cloud, Alibaba Cloud, etc.

**Complejidad**: X3. Gobernanza, seguridad, costos se multiplican. Típico en empresas MUY grandes (Fortune 500)."

---

## MODELOS DE SERVICIO: IaaS, PaaS, SaaS (8 min: 0:17 - 0:25)

**Slides 9-12**

"La pregunta: **¿Quién gestiona qué?**"

### IaaS - Infraestructura como Servicio (3 min)

"**IaaS**: Proveedor gestiona hardware + red + virtualización. **Tú** gestiona SO, aplicación, datos.

**Ejemplo AWS**: EC2 (máquinas virtuales)
- AWS: Te da el hardware virtualizado
- Tú: Instalas Linux, Apache, tu app, configuras todo

**Tabla de responsabilidad**:
```
Aplicación    [CLIENTE gestiona]
Datos         [CLIENTE gestiona]
Runtime       [CLIENTE gestiona]
SO            [CLIENTE gestiona]
---
Virtualización [AWS gestiona]
Redes         [AWS gestiona]
Hardware      [AWS gestiona]
```

**Ventajas**:
- Máximo control (es tu máquina virtualizada)
- Flexible (instala lo que quieras)
- Escalable (suma instancias)

**Desventajas**:
- Mayor complejidad (tienes responsabilidad de todo arriba)

**Caso**: Startup tech → EC2. Control total, costo razonable."

### PaaS - Plataforma como Servicio (2 min)

"**PaaS**: Proveedor gestiona hasta runtime. **Tú solo** escribes código + datos.

**Ejemplo AWS**: Elastic Beanstalk
- AWS: Gestiona servidores, OS, runtime (Node.js, Python)
- Tú: Subes tu código `npm start` y escala automáticamente

**Tabla de responsabilidad**:
```
Aplicación    [CLIENTE gestiona]
Datos         [CLIENTE gestiona]
---
Runtime       [AWS gestiona]
SO            [AWS gestiona]
Virtualización [AWS gestiona]
Redes         [AWS gestiona]
Hardware      [AWS gestiona]
```

**Ventajas**:
- Desarrollo rápido (focus en código)
- Escalabilidad automática
- Menos infraestructura

**Desventajas**:
- Menos flexible (solo Node/Python/Java)
- Vendor lock-in (Beanstalk es AWS-only)

**Caso**: Startup MVP → Beanstalk. Rapido al mercado, sacrifica control."

### SaaS - Software como Servicio (2 min)

"**SaaS**: Proveedor gestiona TODO. **Tú solo USAS** la app.

**Ejemplos**: 
- Salesforce (CRM)
- Microsoft 365 (Office)
- Slack (colaboración)
- Gmail (correo)

**Tabla de responsabilidad**:
```
PROVEEDOR gestiona TODO
---
[Aplicación, Datos, Runtime, SO, Virtualización, Redes, Hardware]
```

**Ventajas**:
- Cero instalación
- Acceso web desde cualquier lugar
- Bajo mantenimiento (siempre actualizado)

**Desventajas**:
- Poco control (no es tuya)
- Integración limitada
- Seguridad en manos del proveedor

**Punto clave**: La mayoría de empresas MEZCLA: SaaS para email (Google Workspace), IaaS para aplicaciones críticas (EC2), PaaS para microservicios."

---

## COMPARATIVA MULTICLOUD (10 min: 0:25 - 0:35)

**Slides 13-18**

"El mercado cloud 2026 es un oligopolio: **tres gigantes dominan**."

### AWS - El Pionero (3 min)

"**Amazon Web Services**:
- Cuota: 32% del mercado ($45B+ anual)
- Lanzamiento: 2006 (la primera)
- Regiones: 60+ en el mundo

**Filosofía**: Innovación rápida. AWS lanza un servicio nuevo cada 3 días (no exagero).

**Fortalezas**:
- 200+ servicios (mayor catálogo)
- Documentación mejor
- Comunidad más grande (si tienes error, alguien en SO ya lo resolvió)
- Todas las startups nacen aquí

**Debilidades**:
- Complejidad: Tanta opción = parálisis del decisor
- Pricing: Es cheap pero opaco (puede ser sorpresa)

**Caso de uso real**: Netflix → AWS S3 (100M+ usuarios, cada película=2GB). Si usaran on-premise, costaría $1B/año en hardware. AWS: escalable, on-demand."

### Microsoft Azure - El Corporativo (2 min)

"**Microsoft Azure**:
- Cuota: 20% del mercado ($30B+)
- Lanzamiento: 2010
- Regiones: 60+

**Filosofía**: 'Usar lo que ya tienes' → Si usan Office 365, Teams, Entra ID, Azure es natural.

**Fortalezas**:
- Integración profunda Microsoft ecosystem
- Compliance fuerte (HIPAA, GDPR, FedRAMP)
- Híbrida nativa (Azure Arc conecta on-premise + cloud)
- Mejor si usas .NET/SharePoint

**Debilidades**:
- Subredes diseñadas diferente a AWS (REGIONAL, no atada a AZ) → arquitectura diverge
- UI más compleja que AWS

**Caso de uso real**: Banco → Azure. ¿Por qué? HIPAA compliance (regulatorio), ya usan Office 365."

### Google Cloud Platform - El AI/ML (2 min)

"**Google Cloud**:
- Cuota: 15% del mercado ($10B+)
- Lanzamiento: 2012
- Regiones: 40+

**Filosofía**: 'IA/ML primero'. Google inventa máquina learning, lo pone en GCP.

**Fortalezas**:
- BigQuery (para análitica masiva, sin ops)
- ML nativa (modelos pre-entrenados)
- Infraestructura robusta (Google maneja YouTube, Gmail)
- **Crecimiento 82% YoY** (más rápido que AWS/Azure)

**Debilidades**:
- Ecosistema más pequeño (menos servicios)
- Comunidad menor

**Caso de uso real**: Empresa de datos → GCP. BigQuery vs Redshift: BigQuery no requiere tuning, escalable sin límite."

### Tabla de Equivalencias (1 min)

"Mismo **concepto** → **nombres diferentes**:

| Necesidad | AWS | Azure | GCP |
|---|---|---|---|
| Máquina virtual | EC2 | Virtual Machine | Compute Engine |
| Contenedores | EKS | AKS | GKE |
| Serverless | Lambda | Functions | Cloud Functions |
| Object Storage | S3 | Blob Storage | Cloud Storage |
| SQL Database | RDS | SQL Database | Cloud SQL |
| NoSQL | DynamoDB | Cosmos DB | Firestore |
| Load Balancer | ALB | Load Balancer | Cloud LB |

**Punto**: Aprendes arquitectura en AWS → Puedes transportar a Azure o GCP (conceptos idénticos, servicios diferentes)."

---

## ARQUITECTURA REDES AWS (15 min: 0:50 - 1:05)

**Slides 19-28**

"Ahora entramos en **lo técnico serio**. Las redes son la BASE de toda arquitectura cloud. Sin entender VPC, Security Groups, route tables, **no puedes diseñar nada seguro**."

### VPC - Virtual Private Cloud (2 min)

"**VPC**: Tu red privada aislada en AWS. Como un data center virtual.

Componentes:
- **CIDR Block**: Rango de IPs. Ej: 10.0.0.0/16 → 65,536 IPs disponibles
- **Availability Zones (AZs)**: Data centers aislados dentro una región
  - us-east-1a (DC físico 1)
  - us-east-1b (DC físico 2, 50km de distancia)
  - us-east-1c (DC físico 3)
  
**Crítico**: Si un AZ falla (terremoto, apagón), los otros dos quedan en pie.

**Subredes**: Divisiones de VPC, cada una **en UNA sola AZ**:
```
VPC 10.0.0.0/16
├─ Subred Pública AZ-a 10.0.1.0/24 (256 IPs)
├─ Subred Privada AZ-a 10.0.10.0/24
├─ Subred Privada AZ-b 10.0.11.0/24 
└─ Subred Privada AZ-c 10.0.12.0/24
```

**¿Por qué separar?** Aislamiento. Frontend publicitario en subredes públicas. Base de datos en subredes privadas (nadie entra de internet)."

### Subredes Públicas vs Privadas (2 min)

"**Subred Pública**:
- Tiene ruta a **Internet Gateway** (puerta a internet)
- Instancias reciben IP pública (visible desde internet)
- Accesible desde internet (usuario → IP pública → EC2)

```
Cliente (internet) 
  → ALB IP pública 203.0.113.1
  → Subred pública 10.0.1.0/24
```

**Subred Privada**:
- **NO** tiene ruta directa a IGW
- Instancias **NO** reciben IP pública
- Accesibles solo desde dentro VPC
- Si necesitan salir a internet → **NAT Gateway**

```
EC2 privada 10.0.10.5
  → NAT Gateway en subred pública (traduce a IP pública temporal)
  → Internet
  → Respuesta vuelve por IGW
```

**Regla de oro**: 
- Frontend, ALB, bastion hosts → Subredes públicas
- Apps, BD, datos → Subredes privadas"

### Internet Gateway & NAT Gateway (2 min)

"**Internet Gateway (IGW)**:
- Puerta entre VPC ↔ Internet
- Requisitos: Attached a VPC + Ruta en route table
- Costo: Gratis
- Redundancia: Automática

Una vez por VPC (shared por todas subredes públicas).

**NAT Gateway**:
- Permite que instancias **privadas** accedan SALIENTE a internet
- Ubicación: DEBE estar en subred **pública** (necesita IP pública)
- Traducción: IP privada 10.0.10.5 → IP pública temporal NAT
- Costo: ~$32 USD/mes
- **REDUNDANCIA CRÍTICA**: Crear UNO por AZ (si AZ-a cae, EC2s en AZ-a pierden internet a menos que haya NAT en otro AZ)

Ejemplo:
```
EC2 privada AZ-a (10.0.10.5) quiere descargar patch
  → Route table privada: 0.0.0.0/0 → nat-xxxxx (en subred pública AZ-a)
  → NAT Gateway traduce origen a IP pública (52.xx.xx.xx)
  → Paquete sale internet
  → Respuesta llega a NAT (reconoce origen 10.0.10.5)
  → NAT devuelve respuesta a EC2
```

**Problema clásico**: Crear 1 NAT Gateway en AZ-a. Si AZ-a falla, las EC2s en AZ-b pierden internet. **Solución**: NAT Gateway en cada AZ."

### Security Groups (2 min)

"**Security Group**: Firewall a nivel de instancia. **Stateful** (si permite salida, entrada vuelve automática).

**Funciona como una regla que dices SÍ a qué tráfico entra/sale:**

Ejemplo inbound (entrada):
```
Puerto | Protocolo | Fuente | Acción
80     | TCP       | 0.0.0.0/0 | ALLOW (HTTP público)
443    | TCP       | 0.0.0.0/0 | ALLOW (HTTPS público)
22     | TCP       | 203.0.113.0/24 | ALLOW (SSH desde admin)
3306   | TCP       | sg-app | ALLOW (MySQL desde app SG)
---    | --- | --- | DENY (todo lo demás)
```

**Clave**: El último DENY es implícito. Si no dices SÍ, es NO.

**Stateful**: 
- Si permitimos puerto 80 SALIENTE, respuesta entra automáticamente sin regla
- No necesitas: IN:80, OUT:80 (solo OUT:0.0.0.0/0 y las respuestas entran)

**Default SG**: Bloquea TODO entrante, permite TODO saliente.

**Mejor práctica**: SG lo más restrictivo posible:
- ALB: 443 desde 0.0.0.0/0 (usuarios)
- ASG (app): 8080 SOLO desde SG del ALB (no público)
- RDS: 5432 SOLO desde SG de la app (no internet)"

### NACLs (1 min)

"**Network Access Control Lists**: Firewall a nivel de **SUBRED** (no instancia). **Stateless** (debes permitir ENTRADA y SALIDA).

Raramente necesitas modificarlas (Security Groups suelen ser suficientes).

Diferencia clave:
```
Security Group: Por instancia, Stateful, muy usado
NACL: Por subred, Stateless, back-up defensivo
```

Si un Security Group deja pasar algo que NO debería, la NACL lo puede bloquear en la subred entera."

### Route Tables (1 min)

"**Route Table**: Reglas que determinan **a dónde va el tráfico**.

Estructura:
```
Destino CIDR      | Target
10.0.0.0/16       | Local (dentro VPC)
192.168.0.0/16    | pcx-xxxxx (peering otra VPC)
0.0.0.0/0         | igw-xxxxx (internet)
```

Evaluación: **Ruta MÁS ESPECÍFICA gana**.

Si un paquete va a 10.0.1.5:
- Coincide 10.0.0.0/16 (Local) → /16
- Coincide 10.0.1.0/24 (si la añades) → /24
- Gana /24 (más específica)

**Una route table se asocia a una subred**. Toda subred tiene route table (default si no asignas)."

---

## CASO PRÁCTICO: ARQUITECTURA FINTECH (20 min: 1:05 - 1:25)

**Slides 29-40**

"Ahora **juntamos todo** en una arquitectura **real, productiva, segura**.

**Escenario**: Plataforma FinTech de procesamiento de pagos.
- 100K-1M usuarios simultáneos
- Datos regulados (PCI-DSS) → Máxima seguridad
- Requisito: SLA 99.99% (máximo 52 minutos downtime/año)"

### Arquitectura General (1 min)

"```
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

VPC: 10.0.0.0/16
- Subredes Públicas: 10.0.1.0/24 (AZ-a), 10.0.2.0/24 (AZ-b)
- Subredes App: 10.0.10.0/24 (AZ-a), 10.0.11.0/24 (AZ-b)
- Subredes DB: 10.0.20.0/24 (AZ-a), 10.0.21.0/24 (AZ-b)"

### Tier 1: Frontend Público (3 min)

"**Tier 1 = Acceso Público** (Subredes 10.0.1.0, 10.0.2.0)

**Application Load Balancer (ALB)**:
- Distribuye tráfico entrante entre múltiples instancias
- IP pública elástica: 203.0.113.1
- Puerto 443 (HTTPS)
- Health checks: Verifica si instancia backend está viva

**AWS WAF (Web Application Firewall)**:
- Bloquea ataques web: SQL Injection, XSS, DDoS
- Rate limiting: 100 requests/min por IP
- OWASP Top 10 rules activadas

**NAT Gateway** (1 por AZ):
- AZ-a: nat-xxxxx en 10.0.1.0/24
- AZ-b: nat-xxxxx en 10.0.2.0/24
- Costo: ~$32 USD/mes x 2 = $64/mes

**Security Group (ALB)**:
```
Inbound:
  443 TCP desde 0.0.0.0/0 (HTTPS público)
  80 TCP desde 0.0.0.0/0 → redirige a 443

Outbound:
  Todo (ALB puede conectar backend apps)
```"

### Tier 2: Lógica de Negocio (4 min)

"**Tier 2 = Aplicación** (Subredes 10.0.10.0, 10.0.11.0)

**Auto Scaling Group (ASG)**:
- EC2 t3.medium (2 vCPU, 4GB RAM)
- Ubuntu 20.04 + Node.js
- Puerto 8080 (aplicación)
- Min: 2 instancias, Max: 20, Target: CPU 70%

**Escalado automático**:
- CPU sube a 75% → Agregar 2 instancias (5 min)
- 100K usuarios → ~5 instancias
- 1M usuarios → ~20 instancias
- CPU baja a 30% → Remover instancias (mantiene mín 2)

**Health checks**: ALB revisa cada 30s si instancia responde. Si no, la saca del balanceador.

**Security Group (ASG)**:
```
Inbound:
  8080 TCP SOLO desde sg-alb (solo ALB puede mandar a app)

Outbound:
  Todo (necesita conectar BD, internet, S3)
```

**Punto de seguridad crítico**: ASG NO está en subred pública. Usuario no ve sus IPs. ALB es el único gateway."

### Tier 3: Base de Datos (4 min)

"**Tier 3 = Persistencia** (Subredes 10.0.20.0, 10.0.21.0)

**RDS PostgreSQL Multi-AZ**:
- Instancia: db.r5.xlarge (4 vCPU, 32GB RAM, óptima para I/O)
- Almacenamiento: 500GB gp3 (General Purpose, buen balance cost/perf)
- Backup automático: Diarios, 30 días retención
- Failover automático: <2 minutos si primary falla

**Multi-AZ arquitectura**:
- Primary (AZ-a, 10.0.20.100): Recibe writes
- Standby (AZ-b, 10.0.21.100): Sincronización síncrona
- Si Primary falla: Failover automático, Standby promociona a Primary

**Security Group (RDS)**:
```
Inbound:
  5432 TCP SOLO desde sg-app (solo aplicación accede)
  
Outbound:
  Ninguno (BD solo recibe, no inicia conexiones)
```

**Encriptación**:
- En tránsito: SSL/TLS por defecto
- En reposo: KMS (AWS managed key)

**Punto crítico**: BD **NO está en subred pública**. Usuario no puede conectar directamente. Solo App puede (vía SG)."

### Tier 4: Almacenamiento (2 min)

"**Tier 4 = Almacenamiento Persistente** (Global)

**S3 Bucket: fintech-transactions-prod**
- Almacenamiento de transacciones históricas (auditoría, compliance)
- Acceso: Privado (VPC Endpoint S3)
- Versionado: Habilitado
- Encriptación: KMS
- Lifecycle: 
  - STANDARD (0-30d) → Hot, acceso frecuente
  - STANDARD_IA (30-90d) → Warm, acceso infrecuente
  - GLACIER (>90d) → Cold, archivado

**Políticas**:
```
Bucket Policy:
  Denegar: Acceso público
  Permitir: Role IAM de EC2 (solo lectura)
  Permitir: CloudTrail (logs de auditoría)
```

**CloudTrail**: Auditoría de todos los accesos S3 (quién, cuándo, qué).

**Costo**: 100GB/mes * $0.023/GB = $2.30/mes"

### Flujo de Tráfico (4 min)

"**Escenario: Usuario realiza pago**

**1. Cliente → Plataforma** (HTTPS):
```
Cliente (203.0.113.10) HTTPS:443
  ↓ (by internet)
ALB IP pública (203.0.113.1)
  ↓ Route 53 DNS resuelve
Route table pública (10.0.1.0/24): 0.0.0.0/0 → igw-xxxxx
  ↓ IGW desencrypta si necesario, distribuye
ALB desencripta HTTPS → HTTP:8080 (comunicación interna)
  ↓ (ALB balancean entre AZ-a, AZ-b)
ASG EC2-a (10.0.10.50) OR ASG EC2-b (10.0.11.50)
```

**2. Aplicación → Base de Datos** (TCP:5432):
```
EC2-a (10.0.10.50) procesa transacción
  ↓ Conecta RDS PostgreSQL (10.0.20.100)
  ↓ Route table privada (10.0.10.0/24): 10.0.0.0/16 → Local
  ↓ Tráfico local dentro VPC, encriptado KMS
RDS Primary (10.0.20.100)
  ↓ Sincronización síncrona a Standby (10.0.21.100)
  ↓ Commit confirmado a EC2
```

**3. Aplicación → Internet** (por NAT, ej: API de pagos externa):
```
EC2-a (10.0.10.50) necesita conectar MercadoPago API (externo)
  ↓ Route table privada: 0.0.0.0/0 → nat-xxxxx
  ↓ NAT Gateway (10.0.1.254, elástica 203.0.113.10)
  ↓ NAT traduce: origen 10.0.10.50 → 203.0.113.10
  ↓ Paquete sale internet hacia MercadoPago
  ↓ Respuesta vuelve NAT (por IP pública)
  ↓ NAT devuelve a EC2-a
```

**4. Aplicación → S3** (privado, VPC Endpoint):
```
EC2-a (10.0.10.50) archiva transacción a S3
  ↓ VPC Endpoint S3 (privado, ruta en route table)
  ↓ NO sale a internet
  ↓ Conexión privada AWS-interna
S3 Bucket fintech-transactions-prod
```"

### Seguridad Multicapa (2 min)

"**Capa 1: WAF en ALB**
- Bloquea ataques web (SQLi, XSS, DDoS)
- Rate limiting

**Capa 2: Security Groups**
- ALB: 443 desde 0.0.0.0/0 ✓
- ASG: 8080 SOLO desde SG-ALB ✓
- RDS: 5432 SOLO desde SG-ASG ✓
- Segmentación de responsabilidad

**Capa 3: Encriptación**
- En tránsito: TLS 1.3 (HTTPS)
- En reposo: KMS AWS (master key rotada automáticamente)

**Capa 4: Auditoría**
- CloudTrail (todos los API calls)
- VPC Flow Logs (tráfico de red)
- CloudWatch Logs (aplicación)

**Capa 5: Gestión de Secretos**
- Contraseña RDS en AWS Secrets Manager
- Rotación automática cada 30 días
- EC2 accede vía IAM Role (sin hardcode)

**Resultado**: Si 1 EC2 es comprometida, atacante no puede:
- Acceder directamente a RDS (SG bloquea)
- Acceder a otra EC2 (aisladas)
- Salir a internet sin ser detectado (NAT logs)"

---

## CONCLUSIÓN (5 min: 1:25 - 1:30)

**Slides 41-44**

"**Mensaje final**:

El éxito en cloud 2026 **no es elegir AWS vs Azure vs GCP**.

Es **dominar el modelo operacional**:

1. **Seguridad por diseño** (Zero Trust, no confianza por defecto)
2. **Multi-AZ** (sin single points of failure)
3. **Automatización IaC** (Terraform, no clicks)
4. **Monitoreo continuo** (CloudWatch, alertas)
5. **Gobernanza regulatoria** (compliance integrada)

**Tres principios del arquitecto**:
1. **Diseña para fallar** (asume que componentes fallarán)
2. **Automatiza para escalar** (crecimiento sin intervención)
3. **Monitorea para decidir** (observabilidad en tiempo real)

**Preguntas**: Abramos 15 minutos a cualquier duda. No hay respuestas incorrectas, hay curiosidad."

---

## PUNTOS DE ÉNFASIS (DURANTE TODA LA SESIÓN)

- **Seguridad**: Menciona en cada sección (¿Cómo se protege?)
- **Escalabilidad**: ¿Qué pasa si 10x usuarios?
- **Costo**: ¿Cuánto cuesta? ¿Por qué ese precio?
- **Multi-AZ**: Redundancia en TODO
- **Automatización**: Nada manual a escala

---

## RESPUESTAS A PREGUNTAS COMUNES

**P: ¿Por qué AWS en lugar de Azure o GCP?**  
R: AWS es el estándar de facto (32% mercado, primer mover). Aprendes aquí → Transportas a cualquier cloud. Conceptos son idénticos.

**P: ¿Una startup necesita Multi-AZ desde el inicio?**  
R: No. MVP en una AZ (~$500/mes). Producción → Multi-AZ (~$2,000/mes).

**P: ¿Por qué no poner RDS en subred pública?**  
R: Usuario malicioso podría fuerza-brute la contraseña. En privada, ni pueden intentarlo (firewall bloquea).

**P: ¿Cuál es el costo mensual real?**  
R: Ej FinTech: ALB $16 + EC2 $120 + RDS $200 + NAT $64 + S3 $2 = ~$450/mes por 100 usuarios concurrentes.

**P: ¿Qué es "failover automático"?**  
R: Si Primary RDS cae, AWS promociona Standby a Primary en <2 minutos. Aplicación reconecta, cero downtime perceptible.

