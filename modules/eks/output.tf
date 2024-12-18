output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

# If oidc_provider_arn is not directly available from the module, use the data source
data "aws_iam_openid_connect_provider" "eks_oidc" {
  url = "https://oidc.eks.${var.region}.amazonaws.com/id/${module.eks.cluster_id}"
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  value       = data.aws_iam_openid_connect_provider.eks_oidc.arn
}

output "oidc_provider_url" {
  description = "The URL of the OIDC provider for the EKS cluster"
  value       = data.aws_iam_openid_connect_provider.eks_oidc.url
}
