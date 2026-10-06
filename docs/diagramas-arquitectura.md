# Diagramas de Arquitectura - Formato Mermaid

Visualización técnica de la arquitectura FinTech con diagramas profesionales sin emojis.

## 1. Diagrama de Secuencia: Flujo de Transacción

```mermaid
sequenceDiagram
    participant User as Usuario
    participant ALB as Application Load Balancer
    participant Flask as Transaction API (Python)
    participant DDB as DynamoDB
    participant S3 as S3 Storage
    
    User->>ALB: POST /transactions (HTTPS:443)
    ALB->>Flask: Forward to backend (HTTP:8080)
    Flask->>Flask: Validate input
    Flask->>DDB: put_item(transaction)
    DDB-->>Flask: Transaction saved
    Flask->>S3: Fallback backup (async)
    S3-->>Flask: Object stored
    Flask-->>ALB: 201 Created
    ALB-->>User: Response JSON
```

## 2. Diagrama de Secuencia: Auditoría de Transacción

```mermaid
sequenceDiagram
    participant API as Transaction API
    participant Express as Audit API (Node.js)
    participant DDB as DynamoDB Audit
    participant CW as CloudWatch
    
    API->>Express: POST /audit-log
    Express->>Express: Validate
    Express->>DDB: put_item(audit)
    DDB-->>Express: Log saved
    Express->>CW: publishMetric()
    CW-->>Express: Metric recorded
    Express-->>API: 201 Created
```

## 3. Diagrama de Arquitectura: VPC Multi-AZ

```mermaid
graph TB
    subgraph VPC["VPC: 10.0.0.0/16"]
        subgraph AZa["Availability Zone: us-east-1a"]
            IGW["Internet Gateway"]
            ALB1["ALB - Primary"]
            NAT1["NAT Gateway"]
            EC2Py1["EC2 Python (5000)"]
            EC2Node1["EC2 Node.js (3000)"]
        end
        
        subgraph AZb["Availability Zone: us-east-1b"]
            ALB2["ALB - Secondary"]
            NAT2["NAT Gateway"]
            EC2Py2["EC2 Python (5000)"]
            EC2Node2["EC2 Node.js (3000)"]
        end
        
        subgraph DBSubnet["Database Subnet"]
            RDS["RDS PostgreSQL Multi-AZ"]
            DDB["DynamoDB"]
        end
    end
    
    Internet["Internet<br/>203.0.113.1"]
    S3["S3 Bucket<br/>fintech-logs"]
    CloudWatch["CloudWatch<br/>Monitoring"]
    
    Internet -->|HTTPS:443| IGW
    IGW -->|Route| ALB1
    IGW -->|Route| ALB2
    ALB1 -->|HTTP:8080| EC2Py1
    ALB1 -->|HTTP:8080| EC2Node1
    ALB2 -->|HTTP:8080| EC2Py2
    ALB2 -->|HTTP:8080| EC2Node2
    
    EC2Py1 -->|DynamoDB| DDB
    EC2Py2 -->|DynamoDB| DDB
    EC2Node1 -->|DynamoDB| DDB
    EC2Node2 -->|DynamoDB| DDB
    
    EC2Py1 -->|NAT| NAT1
    EC2Py2 -->|NAT| NAT2
    EC2Node1 -->|NAT| NAT1
    EC2Node2 -->|NAT| NAT2
    
    EC2Py1 -->|S3| S3
    EC2Node1 -->|CloudWatch| CloudWatch
```

## 4. Diagrama de Flujo: Procesamiento de Transacción

```mermaid
flowchart TD
    A["Usuario envía<br/>POST /transactions"] 
    B["ALB recibe<br/>HTTPS:443"]
    C["Transaction API<br/>Flask"]
    D["Validar datos"]
    E{Validacion<br/>OK?}
    F["Guardar en<br/>DynamoDB"]
    G{DynamoDB<br/>disponible?}
    H["Respuesta 201<br/>Created"]
    I["Respuesta 400<br/>Bad Request"]
    J["Fallback<br/>S3"]
    K["Log en<br/>CloudWatch"]
    L["Respuesta 500<br/>Error"]
    
    A --> B
    B --> C
    C --> D
    D --> E
    E -->|SI| F
    E -->|NO| I
    F --> G
    G -->|SI| H
    G -->|NO| J
    J --> H
    H --> K
    G -->|ERROR| L
    
    style A fill:#e1f5ff
    style H fill:#c8e6c9
    style I fill:#ffccbc
    style L fill:#ffccbc
    style K fill:#f3e5f5
```

## 5. Diagrama de Flujo: Auditoría

```mermaid
flowchart TD
    A["Evento en<br/>Transaction API"]
    B["Enviar log<br/>Audit API"]
    C["Crear entrada<br/>en DynamoDB"]
    D["Publicar métrica<br/>CloudWatch"]
    E["Almacenar en<br/>base de datos"]
    F["Log completado"]
    
    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    
    style A fill:#fff9c4
    style C fill:#e0f2f1
    style D fill:#f3e5f5
    style F fill:#c8e6c9
```

## 6. Diagrama de Responsabilidad: Shared Responsibility Model

```mermaid
graph LR
    subgraph AWS["AWS Responsabilidad"]
        AWS1["Física: Datacenter"]
        AWS2["Hardware"]
        AWS3["Hypervisor"]
        AWS4["Redes física"]
    end
    
    subgraph SHARED["Compartido"]
        SHARED1["SO"]
        SHARED2["Runtime"]
        SHARED3["Firewall (SG)"]
    end
    
    subgraph CLIENT["Cliente Responsabilidad"]
        CLIENT1["Aplicación"]
        CLIENT2["Datos"]
        CLIENT3["Encriptación"]
        CLIENT4["IAM"]
    end
    
    AWS1 --> SHARED1
    AWS2 --> SHARED2
    AWS3 --> SHARED3
    SHARED1 --> CLIENT1
    SHARED2 --> CLIENT2
    SHARED3 --> CLIENT3
    
    style AWS fill:#e3f2fd
    style SHARED fill:#fff9c4
    style CLIENT fill:#e8f5e9
```

## 7. Diagrama de Estado: Transacción Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Pending: Crear transacción
    Pending --> Processing: Validación OK
    Pending --> Failed: Validación fallida
    Processing --> Completed: Guardada en BD
    Processing --> Fallback: BD no disponible
    Fallback --> Completed: Guardada en S3
    Completed --> [*]
    Failed --> [*]
```

## 8. Diagrama de Componentes: Integración AWS

```mermaid
graph TB
    subgraph AppLayer["Application Layer"]
        Flask["Python API<br/>Flask"]
        Express["Node.js API<br/>Express"]
    end
    
    subgraph DataLayer["Data Layer"]
        DDB["DynamoDB"]
        RDS["RDS PostgreSQL"]
        S3["S3 Storage"]
    end
    
    subgraph MonitoringLayer["Monitoring & Security"]
        CW["CloudWatch"]
        IAM["IAM Roles"]
        KMS["KMS Encryption"]
    end
    
    Flask -->|Read/Write| DDB
    Flask -->|Backup| S3
    Express -->|Audit Log| DDB
    Express -->|Publish| CW
    RDS -.->|Reference| Flask
    DDB -->|Encrypt| KMS
    S3 -->|Encrypt| KMS
    Flask --> IAM
    Express --> IAM
    
    style AppLayer fill:#e1f5ff
    style DataLayer fill:#e8f5e9
    style MonitoringLayer fill:#fce4ec
```

## 9. Diagrama de Red: Traffic Flow

```mermaid
graph LR
    User["Usuario<br/>203.0.113.10"]
    Internet["Internet<br/>Public Route"]
    IGW["Internet Gateway"]
    ALB["ALB<br/>10.0.1.100"]
    
    subgraph PubSub["Subnet Pública<br/>10.0.1.0/24"]
        ALB
    end
    
    subgraph PrivSub["Subnet Privada<br/>10.0.10.0/24"]
        App1["Aplicación<br/>10.0.10.50"]
    end
    
    NAT["NAT Gateway<br/>10.0.1.254"]
    
    User -->|HTTPS:443| Internet
    Internet -->|Route| IGW
    IGW -->|Route| ALB
    ALB -->|HTTP:8080| App1
    App1 -->|Outbound| NAT
    NAT -->|IP Pública| Internet
    
    style User fill:#fff9c4
    style PubSub fill:#c8e6c9
    style PrivSub fill:#e0f2f1
    style NAT fill:#ffccbc
```

## 10. Diagrama de Escala: Auto Scaling

```mermaid
graph TD
    A["CloudWatch<br/>CPU Metric"]
    B{CPU >70%?}
    C["Aumentar<br/>+2 instancias"]
    D["ASG: Máx 20"]
    E{CPU <30%?}
    F["Disminuir<br/>-1 instancia"]
    G["ASG: Mín 2"]
    
    A --> B
    B -->|SI| C
    C --> D
    B -->|NO| E
    E -->|SI| F
    E -->|NO| A
    F --> G
    
    style C fill:#c8e6c9
    style F fill:#ffccbc
```

## Notas sobre Mermaid

Todos los diagramas usan formato Mermaid profesional:
- Sin emojis
- Nomenclatura técnica clara
- Colores significativos (Verde=OK, Rojo=Alerta, Azul=AWS)
- Flujos legibles sin ambigüedad

Para renderizar estos diagramas:
1. Usar herramienta Mermaid online (mermaid.live)
2. Integrar en documentación markdown
3. Exportar a PNG/SVG para presentaciones

## Integración con Archify

Para crear versiones de alta calidad en Archify:
1. Usar estas definiciones Mermaid como referencia
2. Recrear diagrama en canvas Archify
3. Aplicar color corporativo USAC (naranja)
4. Exportar como PDF para documentación oficial

---

Version: 1.0 - Oficial
Última actualización: Octubre 2026
