output "lbc_service_account_name" {
  value = kubernetes_service_account.lbc_service_account.metadata[0].name
}

output "lbc_iam_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller_role.arn
}
