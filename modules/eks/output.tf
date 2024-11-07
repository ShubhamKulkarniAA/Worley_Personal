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
