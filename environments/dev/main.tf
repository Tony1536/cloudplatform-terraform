
# VPC (crea VPC + subnets + IGW + RT + NAT)

module "vpc" {
  source = "../../modules/vpc"

  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  vpc_tag_name = var.vpc_tag_name
  igw_name     = var.igw_name

  # Public subnets
  public_subnet_1a_name = var.public_subnet_1a_name
  public_subnet_1a_cidr = var.public_subnet_1a_cidr
  public_subnet_1a_az   = var.public_subnet_1a_az

  public_subnet_1b_name = var.public_subnet_1b_name
  public_subnet_1b_cidr = var.public_subnet_1b_cidr
  public_subnet_1b_az   = var.public_subnet_1b_az

  public_route_table_name_1a = var.public_route_table_name_1a
  public_route_table_name_1b = var.public_route_table_name_1b

  # Private subnets
  private_subnet_1a_name = var.private_subnet_1a_name
  private_subnet_1a_cidr = var.private_subnet_1a_cidr
  private_subnet_1a_az   = var.private_subnet_1a_az

  private_subnet_1b_name = var.private_subnet_1b_name
  private_subnet_1b_cidr = var.private_subnet_1b_cidr
  private_subnet_1b_az   = var.private_subnet_1b_az

  private_route_table_name_1a = var.private_route_table_name_1a
  private_route_table_name_1b = var.private_route_table_name_1b
}


# Locals
locals {
  vpc_id = module.vpc.vpc_id

  # Nginx listen in 8080 port
  user_data = <<-EOF
    #!/bin/bash
    set -eux

    dnf -y update
    dnf -y install nginx

    sed -i 's/listen       80;/listen       8080;/' /etc/nginx/nginx.conf

    echo "OK from $(hostname) on 8080" > /usr/share/nginx/html/index.html
    systemctl enable --now nginx

    systemctl enable --now amazon-ssm-agent || true
    systemctl restart amazon-ssm-agent || true
  EOF
}

# Security Groups

module "security_groups" {
  source = "../../modules/security-groups"

  alb_sg_name        = var.alb_sg_name
  alb_sg_description = var.alb_sg_description

  app_sg_name        = var.app_sg_name
  app_sg_description = var.app_sg_description

  
  app_port = var.app_port

  vpc_id = local.vpc_id
}


# ALB (Listener 80 -> TG app_port)
module "alb" {
  source = "../../modules/alb"

  vpc_id            = local.vpc_id
  app_port          = var.app_port
  alb_sg_id         = module.security_groups.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_tag_name      = var.alb_tag_name
}


# AMI

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


# IAM 

module "iam" {
  source = "../../modules/iam"
  name_iam_role = "${var.project}-${var.environment}"
}

# ASG (Launch Template + Auto Scaling Group)

module "asg" {
  source = "../../modules/asg"

  name = "${var.project}-${var.environment}"

  private_subnet_ids = module.vpc.private_subnet_ids
  instance_sg_id     = module.security_groups.app_sg_id
  target_group_arn   = module.alb.target_group_arn

  ami_id        = data.aws_ami.al2023.id
  instance_type = var.instance_type

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  # SSM / IAM instance profile
  iam_instance_profile_name = module.iam.instance_profile_name

  user_data = local.user_data
}
#cloudwatch monitoring
module "monitoring" {
  source = "../../modules/monitoring"

  name = "${var.project}-${var.environment}"

  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix

  asg_name = module.asg.asg_name
  min_size = var.min_size

}
# RDS
module "rds" {
  source = "../../modules/rds"

  name = "${var.project}-${var.environment}"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  app_sg_id           = module.security_groups.app_sg_id

  engine         = "postgres"
  engine_version = "16.3"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "cloudplatform"
  username = "cloudplatformadmin"

  port = 5432

  multi_az                 = false
  backup_retention_period  = 1
  deletion_protection      = false
  skip_final_snapshot      = true
}