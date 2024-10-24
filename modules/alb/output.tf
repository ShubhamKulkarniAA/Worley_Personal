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

output "private_nlb_arn" {
  value = aws_lb.private_nlb.arn
}

output "private_nlb_tg_arn" {
  value = aws_lb_target_group.private_nlb_tg.arn
}

output "public_alb_sg_id" {
  value = aws_security_group.public_alb_sg.id
}

output "private_alb_sg_id" {
  value = aws_security_group.private_alb_sg.id
}

output "private_nlb_sg_id" {
  value = aws_security_group.private_nlb_sg.id
}
