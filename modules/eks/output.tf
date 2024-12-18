output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint of the EKS cluster"
}

output "node_group_arn" {
  value       = aws_eks_node_group.default.arn
  description = "The ARN of the EKS node group"
}
