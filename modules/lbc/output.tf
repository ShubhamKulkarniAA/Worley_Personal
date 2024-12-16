output "aws_lb_controller_service_account" {
  description = "The service account for the AWS Load Balancer Controller."
  value       = kubernetes_service_account.aws_lb_controller_sa.metadata[0].name
}

output "aws_lb_controller_role" {
  description = "The IAM role used by the AWS Load Balancer Controller."
  value       = aws_iam_role.aws_lb_controller_role.name
}

output "aws_lb_controller_policy" {
  description = "The IAM policy for the AWS Load Balancer Controller."
  value       = aws_iam_policy.aws_lb_controller_policy.arn
}
