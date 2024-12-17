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
  value       = module.eks.cluster_identity.0.oidc.0.issuer
}

output "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster."
  value       = module.eks.cluster_certificate_authority_data
}
