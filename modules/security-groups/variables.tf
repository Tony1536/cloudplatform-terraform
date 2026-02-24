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

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}
