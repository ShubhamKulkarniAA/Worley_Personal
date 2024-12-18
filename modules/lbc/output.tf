output "lbc_role_arn" {
  description = "The ARN of the IAM Role for AWS Load Balancer Controller"
  value       = aws_iam_role.lbc_role.arn
}

output "lbc_policy_arn" {
  description = "The ARN of the IAM Policy for AWS Load Balancer Controller"
  value       = aws_iam_policy.aws_load_balancer_controller.arn
}
