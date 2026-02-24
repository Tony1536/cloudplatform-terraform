variable "name" {
  description = "Prefix used to name alarms (e.g., cloudplatform-dev)"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ALB arn_suffix used for CloudWatch ApplicationELB metrics"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "Target group arn_suffix used for CloudWatch ApplicationELB metrics"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "min_size" {
  description = "ASG minimum size (used to alarm when fewer instances are InService)"
  type        = number
}
variable "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications (optional)"
  type        = string
  default     = null
}