variable "alb_tag_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group ID attached to the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where the ALB will be deployed"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "app_port" {
  description = "The port number for the application security group to allow traffic from the ALB"
  type        = string
}