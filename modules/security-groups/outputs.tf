output "alb_sg_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.sg_alb.id
}

output "app_sg_id" {
  description = "Security Group ID for App"
  value       = aws_security_group.sg_app.id
}
