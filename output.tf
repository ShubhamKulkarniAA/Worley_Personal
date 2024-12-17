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

# ECR Outputs
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

# EKS Outputs
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



# LBC Outputs
output "aws_lb_controller_service_account" {
  description = "The service account for the AWS Load Balancer Controller."
  value       = module.lbc.aws_lb_controller_service_account
}

output "aws_lb_controller_role" {
  description = "The IAM role used by the AWS Load Balancer Controller."
  value       = module.lbc.aws_lb_controller_role
}

output "aws_lb_controller_policy" {
  description = "The IAM policy for the AWS Load Balancer Controller."
  value       = module.lbc.aws_lb_controller_policy
}
