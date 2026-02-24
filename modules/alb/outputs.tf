output "alb_dns_name" {
  value       = aws_lb.cloudplatform_alb.dns_name
}

output "alb_arn" {
  value       = aws_lb.cloudplatform_alb.arn
}

output "target_group_arn" {
  value       = aws_lb_target_group.cloudplatform_target_group.arn
}

output "listener_arn" {
  value       = aws_lb_listener.cloudplatform_listener.arn
}
output "alb_arn_suffix" {
  description = "ARN suffix del ALB para dimensiones de CloudWatch (ApplicationELB)"
  value       = aws_lb.cloudplatform_alb.arn_suffix
}

output "target_group_arn_suffix" {
  description = "ARN suffix del Target Group para dimensiones de CloudWatch (ApplicationELB)"
  value       = aws_lb_target_group.cloudplatform_target_group.arn_suffix
}