output "public_alb_dns_name" {
  description = "The DNS name of the public ALB"
  value       = aws_lb.public_alb.dns_name
}

output "frontend_target_group_arn" {
  description = "The ARN of the frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "backend_target_group_arn" {
  description = "The ARN of the backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}

output "public_alb_security_group_id" {
  description = "The ID of the security group for the public ALB"
  value       = aws_security_group.public_alb_sg.id
}

output "public_alb_arn" {
  description = "The ARN of the public ALB"
  value       = aws_lb.public_alb.arn
}
