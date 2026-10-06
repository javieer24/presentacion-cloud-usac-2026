variable "aws_region" {
  description = "AWS region donde desplegar"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente (prod, staging, dev)"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block para VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones a usar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "CIDR blocks para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnets" {
  description = "CIDR blocks para subnets privadas (app)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_db_subnets" {
  description = "CIDR blocks para subnets privadas (database)"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para ASG"
  type        = string
  default     = "t3.medium"
}

variable "asg_min_size" {
  description = "Minimo de instancias en ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximo de instancias en ASG"
  type        = number
  default     = 20
}

variable "asg_target_cpu" {
  description = "CPU target para auto scaling"
  type        = number
  default     = 70
}

variable "rds_allocated_storage" {
  description = "Almacenamiento inicial RDS en GB"
  type        = number
  default     = 500
}

variable "rds_instance_class" {
  description = "Clase de instancia RDS"
  type        = string
  default     = "db.r5.xlarge"
}

variable "rds_engine_version" {
  description = "Version de PostgreSQL"
  type        = string
  default     = "14.7"
}

variable "rds_db_name" {
  description = "Nombre de base de datos inicial"
  type        = string
  default     = "fintech"
}

variable "rds_username" {
  description = "Usuario master RDS"
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "rds_password" {
  description = "Contraseña master RDS (GENERAR SEGURA)"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "Nombre S3 bucket (debe ser unico globalmente)"
  type        = string
  default     = "fintech-transactions-prod"
}

variable "enable_encryption" {
  description = "Habilitar encriptacion KMS"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Dias de retencion de backups RDS"
  type        = number
  default     = 30
}
