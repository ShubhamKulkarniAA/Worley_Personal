output "public_alb_arn" {
  value = aws_lb.alb.arn
}

output "public_alb_tg_arn" {
  value = aws_lb_target_group.public_alb_tg.arn
}

/*output "private_alb_arn" {
  value = module.alb.private_alb_arn
}

output "Private_alb_tg_arn" {
  value = module.alb.private_alb_tg_arn
}*/