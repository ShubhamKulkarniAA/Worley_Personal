output "eks_cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "alb_ingress_policy_arn" {
  value = aws_iam_policy.alb_ingress_policy.arn
}

output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

output "alb_ingress_role_policy_attachment_arn" {
  value = aws_iam_role_policy_attachment.alb_ingress_role_policy_attachment.arn
}

# Output for ECR repository URL

output "ecr_repository_url" {
  value = aws_ecr_repository.app1.repository_url
}

output "ecr_access_policy_arn" {
  description = "The ARN of the ECR access policy for the EKS node group"
  value       = aws_iam_policy.ecr_access_policy.arn
}
