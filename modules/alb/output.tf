output "public_alb_dns_name" {
  description = "The DNS name of the public ALB"
  value       = aws_lb.public_alb.dns_name
}

output "public_alb_target_group_arn" {
  description = "The ARN of the public ALB target group"
  value       = aws_lb_target_group.public_alb_tg.arn
}

output "public_alb_security_group_id" {
  description = "The ID of the security group for the public ALB"
  value       = aws_security_group.public_alb_sg.id
}
