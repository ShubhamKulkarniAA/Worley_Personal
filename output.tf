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
output "repository_uris" {
  description = "The repository URLs of the created ECR repositories"
  value       = module.ecr.repository_urls
}

output "repository_names" {
  description = "The names of the created ECR repositories"
  value       = module.ecr.repository_names
}

output "repository_arn" {
  description = "The ARNs of the created ECR repositories"
  value       = module.ecr.repository_arn
}

output "lifecycle_policy" {
  description = "The lifecycle policies applied to the repositories"
  value       = module.ecr.lifecycle_policy
}

# EKS Output
output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks.eks_cluster_certificate_authority
}

output "eks_cluster_role_arn" {
  value = module.eks.cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.eks.node_role_arn
}
