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
