# Security Group - Load Balancer
resource "aws_security_group" "alb" {
  name_prefix = "sg-fintech-alb-"
  vpc_id      = aws_vpc.fintech.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP publico"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS publico"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH administrativo"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida total"
  }

  tags = {
    Name = "sg-fintech-alb"
  }
}

# Security Group - EC2 App
resource "aws_security_group" "app" {
  name_prefix = "sg-fintech-app-"
  vpc_id      = aws_vpc.fintech.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    description     = "App desde ALB"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "SSH interno"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida total"
  }

  tags = {
    Name = "sg-fintech-app"
  }
}

# Security Group - RDS
resource "aws_security_group" "rds" {
  name_prefix = "sg-fintech-rds-"
  vpc_id      = aws_vpc.fintech.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
    description     = "PostgreSQL desde app"
  }

  tags = {
    Name = "sg-fintech-rds"
  }
}

# Application Load Balancer
resource "aws_lb" "fintech" {
  name_prefix        = "ft"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name = "fintech-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "fintech" {
  name_prefix = "ft"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.fintech.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

  tags = {
    Name = "fintech-targets"
  }
}

# ALB Listener
resource "aws_lb_listener" "fintech" {
  load_balancer_arn = aws_lb.fintech.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fintech.arn
  }
}

# Launch Template para ASG
resource "aws_launch_template" "fintech" {
  name_prefix   = "fintech-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "fintech-app-instance"
    }
  }

  user_data = base64encode(file("${path.module}/user_data.sh"))

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "fintech" {
  name_prefix         = "fintech-asg-"
  vpc_zone_identifier = aws_subnet.private_app[*].id
  target_group_arns   = [aws_lb_target_group.fintech.arn]
  health_check_type   = "ELB"
  health_check_grace_period = 300

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_min_size

  launch_template {
    id      = aws_launch_template.fintech.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "fintech-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Scaling Policy - Target Tracking
resource "aws_autoscaling_policy" "fintech_cpu" {
  name                   = "fintech-cpu-tracking"
  autoscaling_group_name = aws_autoscaling_group.fintech.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.asg_target_cpu
  }
}

# RDS Instance
resource "aws_db_instance" "fintech" {
  identifier     = "fintech-db"
  engine         = "postgres"
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class

  allocated_storage     = var.rds_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = var.enable_encryption
  db_name               = var.rds_db_name
  username              = var.rds_username
  password              = var.rds_password
  parameter_group_name  = "default.postgres14"
  skip_final_snapshot   = false
  final_snapshot_identifier = "fintech-db-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  db_subnet_group_name            = aws_db_subnet_group.fintech.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  publicly_accessible             = false
  multi_az                        = true
  backup_retention_period         = var.backup_retention_days
  backup_window                   = "03:00-04:00"
  maintenance_window              = "mon:04:00-mon:05:00"
  auto_minor_version_upgrade      = true
  deletion_protection             = true
  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Name = "fintech-db"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "fintech" {
  bucket_prefix = "fintech-transactions-"

  tags = {
    Name = "fintech-transactions-prod"
  }
}

# S3 Versioning
resource "aws_s3_bucket_versioning" "fintech" {
  bucket = aws_s3_bucket.fintech.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "fintech" {
  bucket = aws_s3_bucket.fintech.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 Block Public Access
resource "aws_s3_bucket_public_access_block" "fintech" {
  bucket = aws_s3_bucket.fintech.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Lifecycle Policy
resource "aws_s3_bucket_lifecycle_configuration" "fintech" {
  bucket = aws_s3_bucket.fintech.id

  rule {
    id     = "transition-to-ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

# Data source para AMI Ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
