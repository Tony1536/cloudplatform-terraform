variable "name" {
  description = "Prefijo para nombrar recursos (ej: cloudplatform-dev)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID para las instancias del ASG"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas donde vivirá el ASG"
  type        = list(string)
}

variable "instance_sg_id" {
  description = "Security Group ID para las instancias (app SG)"
  type        = string
}

variable "target_group_arn" {
  description = "ARN del Target Group del ALB"
  type        = string
}

variable "desired_capacity" {
  description = "Cantidad deseada de instancias"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Mínimo de instancias"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Máximo de instancias"
  type        = number
  default     = 4
}

variable "iam_instance_profile_name" {
  description = "Nombre del IAM Instance Profile para el Launch Template"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Script de arranque en texto plano (se convierte a base64 en el LT)"
  type        = string
  default     = null
}
output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.cloudplatform_asg.name
}