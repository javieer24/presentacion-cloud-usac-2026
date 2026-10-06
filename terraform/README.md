# Terraform - Despliegue Automatizado FinTech

Infraestructura como Codigo (IaC) para desplegar automáticamente la arquitectura FinTech en AWS.

---

## Requisitos Previos

- Terraform >= 1.0 instalado
- AWS CLI >= 2.0 configurado
- Credenciales AWS con permisos suficientes
- Región AWS: us-east-1 (configurable)

---

## Estructura de Archivos

```
terraform/
├── main.tf                      # VPC, subnets, IGW, NAT, route tables
├── ec2.tf                       # ALB, ASG, RDS, S3, security groups
├── variables.tf                 # Declaracion de variables
├── outputs.tf                   # Outputs del despliegue
├── user_data.sh                 # Script de inicializacion EC2
├── terraform.tfvars.example     # Ejemplo de valores (copiar y editar)
└── README.md                    # Este archivo
```

---

## Pasos para Desplegar

### 1. Configurar Variables

Copiar ejemplo de valores:
```bash
cp terraform.tfvars.example terraform.tfvars
```

Editar `terraform.tfvars` con tus valores (especialmente contraseña RDS):
```hcl
rds_password = "TU_CONTRASEÑA_SEGURA_AQUI"
s3_bucket_name = "fintech-transactions-prod-CUENTA-ID"
aws_region = "us-east-1"
```

### 2. Inicializar Terraform

```bash
cd terraform
terraform init
```

Esto descarga el provider de AWS y inicializa el directorio.

### 3. Planificar Despliegue

```bash
terraform plan
```

Esto muestra exactamente qué recursos se crearán. Revisar salida para confirmar.

### 4. Aplicar Despliegue

```bash
terraform apply
```

Terraform pedirá confirmacion. Escribir `yes` para proceder.

El despliegue tarda ~15-20 minutos (la mayoría en RDS Multi-AZ).

### 5. Obtener Outputs

Una vez completado, ver los resultados:
```bash
terraform output
```

Esto muestra:
- ALB DNS name (para acceder)
- RDS endpoint (para conectar BD)
- S3 bucket name
- ASG configuration

---

## Acceder a la Aplicación

Una vez desplegado:

```bash
# Obtener DNS del ALB
ALB_DNS=$(terraform output -raw alb_dns_name)

# Probar salud
curl http://$ALB_DNS/health

# Acceso web
open http://$ALB_DNS
```

---

## Actualizar Configuración

Cambiar variables en `terraform.tfvars` y luego:

```bash
terraform plan
terraform apply
```

Terraform detecta cambios y actualiza solo los necesario.

---

## Eliminar Todo (Limpieza)

**ADVERTENCIA: Esto elimina TODOS los recursos.**

```bash
terraform destroy
```

Escribir `yes` para confirmar.

Los datos RDS se guardan en snapshot final antes de borrar.

---

## Configuración de Ejemplo

### Escenario: Desarrollo (Bajo costo)

```hcl
instance_type = "t3.small"
asg_min_size = 1
asg_max_size = 3
rds_instance_class = "db.t3.micro"
rds_allocated_storage = 100
backup_retention_days = 7
```

### Escenario: Produccion (Alto disponibilidad)

```hcl
instance_type = "t3.large"
asg_min_size = 3
asg_max_size = 30
rds_instance_class = "db.r5.xlarge"
rds_allocated_storage = 1000
backup_retention_days = 30
```

---

## Costos Estimados (Produccion)

| Componente | Mensual |
|---|---|
| ALB | $16 |
| EC2 (3-5 instancias) | $150-250 |
| RDS (db.r5.xlarge) | $600-800 |
| NAT Gateway (2x) | $64 |
| S3 (100GB) | $2-5 |
| **TOTAL** | ~$850-1,200 |

Nota: Costos pueden variar. Usar AWS Cost Calculator para estimacion exacta.

---

## Problemas Comunes

### Error: "Credential not found"
```bash
# Configurar credenciales AWS
aws configure

# O usar variables de entorno
export AWS_ACCESS_KEY_ID="tu-key"
export AWS_SECRET_ACCESS_KEY="tu-secret"
export AWS_DEFAULT_REGION="us-east-1"
```

### Error: "InvalidParameterValue - S3 bucket already exists"
Los nombres S3 deben ser globalmente unicos. Agregar sufijo:
```hcl
s3_bucket_name = "fintech-transactions-prod-12345"
```

### RDS tarda mucho tiempo
RDS Multi-AZ puede tardar 15-20 minutos. Es normal. Usar:
```bash
aws rds describe-db-instances --db-instance-identifier fintech-db
```

### Cambiar region
```hcl
aws_region = "eu-west-1"
```

Luego `terraform plan` y `terraform apply`.

---

## Mejoras Futuras

- Agregar CloudFront CDN
- Agregar RDS Aurora (mejor performance)
- Agregar ElastiCache para cache distribuido
- Agregar WAF rules mas estrictas
- Agregar monitoring con CloudWatch

---

## Documentacion Adicional

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Architecture Best Practices](https://docs.aws.amazon.com/wellarchitected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

**Autor**: Javier Andrés Monjes Solórzano  
**Fecha**: Octubre 2026
