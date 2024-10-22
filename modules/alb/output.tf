output "public_alb_arn" {
  value = aws_lb.public_alb.arn
}

output "public_alb_tg_arn" {
  value = aws_lb_target_group.public_alb_tg.arn
}

output "private_alb_arn" {
  value = aws_lb.private_alb.arn
}

output "private_alb_tg_arn" {
  value = aws_lb_target_group.private_alb_tg.arn
}

output "public_alb_dns_name" {
  value = aws_lb.public_alb.dns_name
}