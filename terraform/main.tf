terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "fintech-prod"
      ManagedBy   = "Terraform"
      CreatedAt   = timestamp()
    }
  }
}

# VPC Principal
resource "aws_vpc" "fintech" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "fintech-prod-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "fintech" {
  vpc_id = aws_vpc.fintech.id

  tags = {
    Name = "fintech-igw"
  }
}

# Subnets Públicas
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.fintech.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "fintech-public-${var.availability_zones[count.index]}"
    Type = "Public"
  }
}

# Subnets Privadas - App
resource "aws_subnet" "private_app" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.fintech.id
  cidr_block        = var.private_app_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "fintech-app-${var.availability_zones[count.index]}"
    Type = "Private-App"
  }
}

# Subnets Privadas - Database
resource "aws_subnet" "private_db" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.fintech.id
  cidr_block        = var.private_db_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "fintech-db-${var.availability_zones[count.index]}"
    Type = "Private-DB"
  }
}

# Elastic IPs para NAT Gateways
resource "aws_eip" "nat" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = {
    Name = "eip-nat-${var.availability_zones[count.index]}"
  }

  depends_on = [aws_internet_gateway.fintech]
}

# NAT Gateways (1 por AZ para redundancia)
resource "aws_nat_gateway" "fintech" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-${var.availability_zones[count.index]}"
  }

  depends_on = [aws_internet_gateway.fintech]
}

# Route Table Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.fintech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fintech.id
  }

  tags = {
    Name = "fintech-public-rt"
  }
}

# Asociar Subnets Públicas a Route Table Pública
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Route Table Privada (1 por AZ para redundancia NAT)
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.fintech.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.fintech[count.index].id
  }

  tags = {
    Name = "fintech-private-rt-${var.availability_zones[count.index]}"
  }
}

# Asociar Subnets Privadas App a Route Table Privada
resource "aws_route_table_association" "private_app" {
  count          = length(aws_subnet.private_app)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Asociar Subnets Privadas DB a Route Table Privada
resource "aws_route_table_association" "private_db" {
  count          = length(aws_subnet.private_db)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# DB Subnet Group
resource "aws_db_subnet_group" "fintech" {
  name       = "fintech-db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = {
    Name = "fintech-db-subnet-group"
  }
}

# VPC Endpoint para S3 (Acceso privado)
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.fintech.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = concat(
    [aws_route_table.public.id],
    aws_route_table.private[*].id
  )

  tags = {
    Name = "fintech-s3-endpoint"
  }
}
