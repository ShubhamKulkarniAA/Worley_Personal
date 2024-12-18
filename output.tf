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

#ECR Outputs
# output "repository_uris" {
#   description = "The repository URLs of the created ECR repositories"
#   value       = module.ecr.repository_urls
# }

# output "repository_names" {
#   description = "The names of the created ECR repositories"
#   value       = module.ecr.repository_names
# }

# output "repository_arn" {
#   description = "The ARNs of the created ECR repositories"
#   value       = module.ecr.repository_arn
# }

# output "lifecycle_policy" {
#   description = "The lifecycle policies applied to the repositories"
#   value       = module.ecr.lifecycle_policy
# }

# EKS Output
output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
