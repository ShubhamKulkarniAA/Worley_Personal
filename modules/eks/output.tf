output "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "The ARN of the IAM role for the EKS node group"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = aws_eks_node_group.eks_node_group.arn
}

# Output the IAM OIDC provider ARN if available
output "eks_oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.eks_oidc_provider.arn
}

# Output the IAM role ARN for ALB Ingress Controller
output "alb_ingress_controller_role_arn" {
  description = "The ARN of the IAM role for the ALB Ingress Controller"
  value       = aws_iam_role.alb_ingress_controller.arn
}

# Output the name of the ALB Ingress Controller Kubernetes service account
output "alb_ingress_controller_service_account" {
  description = "The name of the ALB Ingress Controller service account"
  value       = kubernetes_service_account.alb_ingress_controller.metadata[0].name
}

# Output the VPC ID where the EKS cluster resides
output "vpc_id" {
  description = "The VPC ID where the EKS cluster is located"
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].vpc_id
}
