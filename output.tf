# VPC Output
output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "rds_private_subnet1_id" {
  value = module.vpc.rds_private_subnet1_id
}

output "rds_private_subnet2_id" {
  value = module.vpc.rds_private_subnet2_id
}

output "public_subnet1_id" {
  value = module.vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.vpc.public_subnet2_id
}

output "private_subnet1_id" {
  value = module.vpc.private_subnet1_id
}

output "private_subnet2_id" {
  value = module.vpc.private_subnet2_id
}

# EKS Output
output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_oidc_provider_arn" {
  description = "EKS OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = var.cluster_name
}
