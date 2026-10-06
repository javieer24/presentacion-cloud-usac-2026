output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.fintech.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.fintech.cidr_block
}

output "public_subnet_ids" {
  description = "IDs de subnets publicas"
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "IDs de subnets privadas (app)"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "IDs de subnets privadas (db)"
  value       = aws_subnet.private_db[*].id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.fintech.id
}

output "nat_gateway_ips" {
  description = "IPs elasticas de NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "alb_dns_name" {
  description = "DNS name del Load Balancer"
  value       = aws_lb.fintech.dns_name
}

output "alb_arn" {
  description = "ARN del Load Balancer"
  value       = aws_lb.fintech.arn
}

output "alb_security_group_id" {
  description = "ID del Security Group del ALB"
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "ID del Security Group de la app"
  value       = aws_security_group.app.id
}

output "rds_security_group_id" {
  description = "ID del Security Group de RDS"
  value       = aws_security_group.rds.id
}

output "asg_name" {
  description = "Nombre del Auto Scaling Group"
  value       = aws_autoscaling_group.fintech.name
}

output "asg_min_size" {
  description = "Tamano minimo del ASG"
  value       = aws_autoscaling_group.fintech.min_size
}

output "asg_max_size" {
  description = "Tamano maximo del ASG"
  value       = aws_autoscaling_group.fintech.max_size
}

output "rds_endpoint" {
  description = "Endpoint de RDS"
  value       = aws_db_instance.fintech.endpoint
}

output "rds_database_name" {
  description = "Nombre de base de datos RDS"
  value       = aws_db_instance.fintech.db_name
}

output "s3_bucket_name" {
  description = "Nombre del S3 bucket"
  value       = aws_s3_bucket.fintech.id
}

output "s3_bucket_arn" {
  description = "ARN del S3 bucket"
  value       = aws_s3_bucket.fintech.arn
}

output "deployment_summary" {
  description = "Resumen del despliegue"
  value = {
    vpc_cidr           = aws_vpc.fintech.cidr_block
    alb_dns            = aws_lb.fintech.dns_name
    rds_endpoint       = aws_db_instance.fintech.endpoint
    asg_name           = aws_autoscaling_group.fintech.name
    s3_bucket          = aws_s3_bucket.fintech.id
    region             = var.aws_region
    availability_zones = var.availability_zones
  }
}
