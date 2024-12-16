output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_provider" {
  description = "The OIDC provider URL of the EKS cluster."
  value       = module.eks.cluster_oidc_issuer_url
}
