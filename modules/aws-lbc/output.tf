
output "aws_lbc_iam_role" {
  value = aws_iam_role.lbc_role.arn
}

output "aws_lbc_policy_arn" {
  value = aws_iam_policy.lbc_custom_policy.arn
}

output "helm_release_version" {
  value = helm_release.aws_load_balancer_controller.version
}
