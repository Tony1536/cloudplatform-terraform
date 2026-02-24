variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  description = "The instance tenancy attribute for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
}

variable "vpc_tag_name" {
  type = string
}

variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "project" {
  description = "Nombre del proyecto (ej: cloudplatform)"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
}

# variables alb security group
variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "alb_sg_description" {
  description = "Description of the ALB security group"
  type        = string
}

variable "app_port" {
  description = "The port from which the ALB will communicate with the application security group"
  type        = number
}

# variables app security group
variable "app_sg_name" {
  description = "Name of the application security group"
  type        = string
}

variable "app_sg_description" {
  description = "Description of the application security group"
  type        = string
}

variable "alb_tag_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

# variables public subnets
variable "public_subnet_1a_cidr" {
  description = "The CIDR block for public subnet 1a."
  type        = string
}

variable "public_subnet_1b_cidr" {
  description = "The CIDR block for public subnet 1b."
  type        = string
}

variable "public_subnet_1a_az" {
  description = "The availability zone for public subnet 1a."
  type        = string
}

variable "public_subnet_1b_az" {
  description = "The availability zone for public subnet 1b."
  type        = string
}

variable "public_subnet_1a_name" {
  description = "The name tag for public subnet 1a."
  type        = string
}

variable "public_subnet_1b_name" {
  description = "The name tag for public subnet 1b."
  type        = string
}

# variables private subnets
variable "private_subnet_1a_cidr" {
  description = "The CIDR block for private subnet 1a."
  type        = string
}

variable "private_subnet_1b_cidr" {
  description = "The CIDR block for private subnet 1b."
  type        = string
}

variable "private_subnet_1a_az" {
  description = "The availability zone for private subnet 1a."
  type        = string
}

variable "private_subnet_1b_az" {
  description = "The availability zone for private subnet 1b."
  type        = string
}

variable "private_subnet_1a_name" {
  description = "The name tag for private subnet 1a."
  type        = string
}

variable "private_subnet_1b_name" {
  description = "The name tag for private subnet 1b."
  type        = string
}

# variables internet gateway
variable "igw_name" {
  description = "The name tag for Internet gateway."
  type        = string
}

# variables route table
variable "public_route_table_name_1a" {
  description = "The name tag for the public route table 1a."
  type        = string
}

variable "public_route_table_name_1b" {
  description = "The name tag for the public route table 1b."
  type        = string
}

variable "private_route_table_name_1a" {
  description = "The name tag for the private route table 1a."
  type        = string
}

variable "private_route_table_name_1b" {
  description = "The name tag for the private route table 1b."
  type        = string
}

# ASG / Compute
variable "instance_type" {
  description = "Tipo de instancia para el ASG"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Cantidad deseada de instancias en el ASG"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Mínimo de instancias en el ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Máximo de instancias en el ASG"
  type        = number
  default     = 2
}