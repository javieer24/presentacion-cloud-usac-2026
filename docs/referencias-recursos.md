# Referencias y Recursos - Ecosistema Cloud 2026

Compilación de recursos, documentación y referencias para profundizar en los conceptos de la presentación.

## 📚 Documentación Oficial AWS

### General
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/) - Guía de diseño para arquitecturas seguras, eficientes y escalables
- [AWS Architecture Center](https://aws.amazon.com/architecture/) - Diagramas y patrones de arquitectura reales
- [AWS Best Practices](https://docs.aws.amazon.com/general/latest/gr/aws-general.pdf) - Guía de mejores prácticas global

### Servicios Core

#### Networking
- [VPC Documentation](https://docs.aws.amazon.com/vpc/) - Configuración y gestión de redes
- [Security Groups Guide](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) - Firewall por instancia
- [NACLs Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) - Firewall por subred
- [Direct Connect Guide](https://docs.aws.amazon.com/directconnect/) - Conexiones dedicadas privadas
- [Transit Gateway Overview](https://docs.aws.amazon.com/vpc/latest/tgw/) - Hub-and-Spoke networking

#### Cómputo
- [EC2 Documentation](https://docs.aws.amazon.com/ec2/) - Máquinas virtuales elásticas
- [Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/) - Escalado automático de instancias
- [Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/) - ALB, NLB, Classic LB

#### Base de Datos
- [RDS Documentation](https://docs.aws.amazon.com/rds/) - Bases de datos gestionadas
- [RDS Multi-AZ Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html) - Failover automático
- [Aurora Documentation](https://docs.aws.amazon.com/rds/latest/userguide/Aurora.Overview.html) - Motor nativo de AWS

#### Almacenamiento
- [S3 Documentation](https://docs.aws.amazon.com/s3/) - Object storage ilimitado
- [EBS Documentation](https://docs.aws.amazon.com/ebs/) - Block storage para EC2
- [EFS Documentation](https://docs.aws.amazon.com/efs/) - File storage compartido (NFS)

#### Seguridad
- [IAM Documentation](https://docs.aws.amazon.com/iam/) - Identity & Access Management
- [KMS Documentation](https://docs.aws.amazon.com/kms/) - Key Management Service
- [AWS WAF Documentation](https://docs.aws.amazon.com/waf/) - Web Application Firewall

#### Monitoreo & Auditoría
- [CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch/) - Monitoreo y logs
- [CloudTrail Documentation](https://docs.aws.amazon.com/cloudtrail/) - Auditoría de API calls
- [VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html) - Análisis de tráfico red

## 🏆 Certificaciones AWS

### AWS Solutions Architect Associate (SAA-C03)
**Requisito**: 130 minutos, 65 preguntas  
**Costo**: $150 USD  
**Tópicos cubiertos**:
- Arquitectura de aplicaciones escalables
- Seguridad
- Almacenamiento
- Bases de datos
- Redes

**Recursos de estudio**:
- [A Cloud Guru - SAA-C03](https://www.acloudstorage.com/learn/aws-certified-solutions-architect-associate) (curso completo)
- [Linux Academy Practice Exams](https://www.pluralsight.com/) (300+ preguntas)
- [AWS Official Sample Questions](https://d1.awsstatic.com/training-and-certification/docs-sa-assoc/AWS-Certified-Solutions-Architect-Associate_Sample-Questions.pdf)

### AWS Certified Cloud Practitioner (CLF-C02)
**Requisito**: 90 minutos, 65 preguntas  
**Costo**: $100 USD  
**Tópicos básicos**: Conceptos cloud, servicios AWS, seguridad, precios

## 🛠️ Herramientas & Frameworks

### Infrastructure as Code (IaC)

**Terraform** (agnóstico, recomendado):
- [Terraform Official Docs](https://www.terraform.io/docs)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

Ejemplo básico VPC:
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}
```

**AWS CloudFormation** (nativo, JSON/YAML):
- [CloudFormation Documentation](https://docs.aws.amazon.com/cloudformation/)
- [Sample Templates](https://aws.amazon.com/cloudformation/resources/templates/)

### Diseño & Diagramación

**Herramientas recomendadas**:
- [AWS Architecture Icons](https://aws.amazon.com/architecture/icons/) - Iconografía oficial
- [Draw.io (gratuito)](https://draw.io/) - Editor de diagramas
- [Lucidchart](https://www.lucidchart.com/) - Diagramación colaborativa
- [CloudCraft](https://www.cloudcraft.co/) - Visualizador 3D AWS

### Auditoría & Compliance

**AWS native**:
- [AWS Config](https://docs.aws.amazon.com/config/) - Compliance tracking
- [AWS Security Hub](https://docs.aws.amazon.com/securityhub/) - Central de seguridad
- [GuardDuty](https://docs.aws.amazon.com/guardduty/) - Threat detection

**Terceros**:
- [Prowler](https://github.com/prowler-cloud/prowler) - AWS security audit (open source)
- [CloudMapper](https://github.com/duo-labs/cloudmapper) - Visualización de redes

## 📖 Libros Recomendados

| Libro | Autor | Objetivo | Nivel |
|---|---|---|---|
| **AWS Well-Architected Framework** | Amazon | Diseño de arquitecturas | Intermedio |
| **Architecting on AWS** | Amazon | Soluciones escalables | Intermedio |
| **AWS Certified Solutions Architect Study Guide** | Ben Piper | Certificación SAA | Principiante |
| **Terraform: Up & Running** | Yevgeniy Brikman | IaC con Terraform | Intermedio |
| **The Phoenix Project** | Gene Kim | DevOps y cultura | Ejecutivo |

## 🎓 Cursos Online

### Plataformas

| Plataforma | Costo | Cobertura | Pros |
|---|---|---|---|
| [A Cloud Guru](https://acloudguru.com/) | $29-99/mes | AWS, Azure, GCP | Laboratorios hands-on |
| [Linux Academy](https://www.pluralsight.com/) | $29-299/mes | AWS especializado | Profundo en certifications |
| [Udemy](https://www.udemy.com/) | $10-50 (ofertas) | AWS general | Acceso de por vida |
| [Coursera](https://www.coursera.org/) | Gratis-$50/mes | AWS Fundamentals | Certificados reconocidos |
| [CloudAcademy](https://cloudacademy.com/) | $39-60/mes | AWS/Azure/GCP | Cursos cortos y actualizados |

### Cursos Específicos Recomendados

**AWS Architecture Fundamentals**:
- [Architecting for the Cloud - AWS](https://www.aws.training/) (AWS official, gratis)
- [AWS Certified Solutions Architect Associate](https://acloud.guru/learn/aws-certified-solutions-architect-associate) (A Cloud Guru)

**Networking**:
- [Advanced VPC Design](https://www.youtube.com/watch?v=_zWbpyHsxxE) (YouTube - AWS)
- [AWS Networking Workshop](https://networkshop.aws/) (Hands-on labs)

**Security**:
- [Security Engineering on AWS](https://aws.amazon.com/training/learn-security/) (AWS official)
- [AWS Security Best Practices](https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf) (Whitepaper)

## 💻 Laboratorios Hands-On

### AWS Oficial (Gratis)

- [AWS Hands-On Tutorials](https://aws.amazon.com/getting-started/hands-on/) - Labs paso-a-paso
- [AWS Workshop Studio](https://workshops.aws/) - Laboratorios interactivos
- [AWS Immersion Day](https://aws.amazon.com/events/) - Eventos de capacitación

### Terceros

- [A Cloud Guru Sandboxes](https://acloudguru.com/) - Laboratorios con acceso a AWS real
- [Linux Academy Hands-On Labs](https://www.pluralsight.com/labs) - Prácticas guiadas

**Lab Sugerido**: Crear arquitectura FinTech básica
1. Crear VPC (10.0.0.0/16)
2. Crear subredes públicas/privadas
3. Crear ALB en subredes públicas
4. Crear 2 EC2 en subredes privadas (ASG)
5. Crear RDS PostgreSQL Multi-AZ
6. Configurar Security Groups
7. Verificar conectividad
**Tiempo estimado**: 2-3 horas

## 🔗 Comunidades & Foros

### Oficial AWS

- [AWS Forums](https://forums.aws.amazon.com/) - Comunidad oficial
- [AWS subreddit](https://www.reddit.com/r/aws/) - Community discussion
- [AWS re:Invent (anual)](https://reinvent.awsevents.com/) - Conferencia global

### Stackoverflow

- [Tag: amazon-ec2](https://stackoverflow.com/questions/tagged/amazon-ec2)
- [Tag: amazon-rds](https://stackoverflow.com/questions/tagged/amazon-rds)
- [Tag: amazon-vpc](https://stackoverflow.com/questions/tagged/amazon-vpc)

### Slack Communities

- [AWS Developers Slack](https://aws-developers.slack.com/)
- [DevOps Slack](https://devops.com/community/) (incluye AWS channel)

## 📰 Blogs & Articles

### Blogs Especializados

- [AWS Architecture Blog](https://aws.amazon.com/blogs/architecture/) - Patrones y soluciones
- [AWS Security Blog](https://aws.amazon.com/blogs/security/) - Mejores prácticas de seguridad
- [Alexei Ledenev AWS Blog](https://hackerchamp.com/) - Deep dives técnicos
- [Corey Quinn - Last Week in AWS](https://www.lastweekinaws.com/) - Noticias semanales

### Whitepapers (PDF)

- [AWS Security Best Practices](https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf)
- [Architecting for the Cloud](https://d1.awsstatic.com/whitepapers/aws-architecting-for-the-cloud.pdf)
- [AWS Well-Architected Framework](https://d1.awsstatic.com/whitepapers/architecture/AWS_Well-Architected_Framework.pdf)
- [Disaster Recovery Strategies](https://d1.awsstatic.com/whitepapers/disaster_recovery_strategies.pdf)

## 🎬 Videos & YouTube Channels

### Canales Recomendados

| Canal | Contenido | Público |
|---|---|---|
| [AWS Tutorials](https://www.youtube.com/user/AmazonWebServices) | Oficial AWS | Todos |
| [Crash Course AWS](https://www.youtube.com/c/CrashCourses) | Conceptos rápidos | Principiantes |
| [CloudAcademy](https://www.youtube.com/c/CloudAcademyIO) | Cursos cortos | Intermedio |
| [A Cloud Guru](https://www.youtube.com/c/ACloudGuru) | Labs y tutorias | Intermedio+ |

### Videos Específicos

- [AWS EC2 Fundamentals](https://www.youtube.com/watch?v=_1NgRrP20G0) (10 min)
- [AWS VPC Explained](https://www.youtube.com/watch?v=TUTqISsH7nE) (15 min)
- [AWS Security Groups Deep Dive](https://www.youtube.com/watch?v=l0lHq5xK0cQ) (20 min)
- [RDS Multi-AZ Failover](https://www.youtube.com/watch?v=6-8W2N5VqhQ) (8 min)

## 📋 Checklists & Templates

### Arquitectura

- [AWS Well-Architected Review Checklist](https://docs.aws.amazon.com/wellarchitected/latest/userguide/workloads.html)
- [Terraform AWS Checklist](https://www.terraform.io/docs/providers/aws/index.html) (antes de deploy)

### Seguridad

- [PCI-DSS AWS Compliance Checklist](https://d1.awsstatic.com/whitepapers/compliance/PCI_DSS_Compliance_on_AWS.pdf)
- [HIPAA Compliance Checklist](https://d1.awsstatic.com/whitepapers/compliance/HIPAA_Compliance_on_AWS.pdf)

### Deployments

- [Pre-deployment Checklist](https://aws.amazon.com/premiumsupport/knowledge-center/) (buscar "deployment checklist")

## 🧪 Prácticas Recomendadas

### Ejercicio 1: VPC Multi-AZ Básico
**Objetivo**: Entender subnet pública/privada y routing  
**Duración**: 1 hora  
**Archivos**: Terraform para VPC + subredes

### Ejercicio 2: ASG + ALB
**Objetivo**: Escalado automático y distribución de carga  
**Duración**: 2 horas  
**Requisito**: Ejercicio 1 completado

### Ejercicio 3: RDS Multi-AZ + Failover Test
**Objetivo**: Verificar high availability  
**Duración**: 2 horas  
**Requisito**: Ejercicio 2 completado

### Ejercicio 4: Arquitectura FinTech Completa
**Objetivo**: Integración de todos los servicios  
**Duración**: 4 horas  
**Requisito**: Ejercicios 1-3 completados

---

## 📞 Soporte & Contacto

### Soporte AWS

- [AWS Premium Support](https://aws.amazon.com/support/) - Soporte profesional
- [AWS Support Plans](https://aws.amazon.com/support/plans/) - Diferentes niveles
- [AWS Service Health Dashboard](https://health.aws.amazon.com/) - Estado de servicios

### Contacto Instructor

Para preguntas específicas sobre la presentación o laboratorios:
- Correo electrónico disponible en sesión de presentación
- Horarios de oficina: Por confirmar
- Canal de consultas: TBD

---

**Última actualización**: Octubre 2026  
**Versión**: 1.0  
**Responsable**: Javier Andrés Monjes Solórzano
