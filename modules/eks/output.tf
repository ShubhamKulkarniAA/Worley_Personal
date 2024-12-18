output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS."
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "OIDC provider URL for EKS."
  value       = module.eks.oidc_provider_url
}

output "cluster_name" {
  description = "EKS Cluster Name."
  value       = module.eks.cluster_name
}
