output "aws_load_balancer_controller_role_arn" {
  description = "The ARN of the AWS Load Balancer Controller IAM role"
  value       = aws_iam_role.aws_load_balancer_controller.arn
}

output "aws_load_balancer_controller_service_account" {
  description = "The Kubernetes service account for AWS Load Balancer Controller"
  value       = kubernetes_service_account.aws_load_balancer_controller.metadata[0].name
}

output "aws_load_balancer_controller_policy_arn" {
  description = "The ARN of the AWS Load Balancer Controller IAM policy"
  value       = aws_iam_policy.aws_load_balancer_controller.arn
}

output "service_account_name" {
  description = "The name of the service account for AWS Load Balancer Controller"
  value       = eks_service_account.aws_load_balancer_controller.name
}

output "helm_release_name" {
  description = "The name of the Helm release for AWS Load Balancer Controller"
  value       = helm_release.aws_load_balancer_controller.name
}
