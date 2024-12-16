output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_provider" {
  description = "The OIDC provider URL of the EKS cluster."
  value       = module.eks.cluster_oidc_provider
}

output "eks_node_group_names" {
  description = "The names of the EKS node groups."
  value       = module.eks.node_groups
}
