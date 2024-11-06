# VPC Outputs
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

# ALB Outputs
output "public_alb_dns_name" {
  description = "The DNS name of the public ALB"
  value       = module.alb.public_alb_dns_name
}

output "public_alb_target_group_arn" {
  description = "The ARN of the public ALB target group"
  value       = module.alb.public_alb_target_group_arn
}

output "public_alb_security_group_id" {
  description = "The ID of the security group for the public ALB"
  value       = module.alb.public_alb_security_group_id
}

output "public_alb_arn" {
  description = "The ARN of the public ALB"
  value       = module.alb.public_alb_arn
}

# ECR Outputs
output "repository_uris" {
  description = "URIs of the ECR repositories"
  value = {
    for repo_name, repo in module.ecr.ecr_repo :
    repo_name => repo.repository_url
  }
}

output "repository_names" {
  description = "Names of the ECR repositories"
  value = [for repo_name in module.ecr.ecr_repo : repo_name]
}

# EKS Outputs
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
  description = "The ARN of the IAM role for the EKS cluster"
  value       = module.eks.cluster_role_arn
}

output "eks_node_role_arn" {
  description = "The ARN of the IAM role for the EKS node group"
  value       = module.eks.node_role_arn
}

output "oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  value       = module.eks.oidc_provider_url
}

output "eks_fargate_role_arn" {
  description = "The ARN of the IAM role for Fargate"
  value       = module.eks.eks_fargate_role_arn
}

output "fargate_profile_name" {
  description = "The name of the EKS Fargate profile"
  value       = module.eks.fargate_profile_name
}

#LBC Output
output "lbc_service_account_name" {
  description = "The name of the Service Account for the Load Balancer Controller"
  value       = module.lbc.lbc_service_account_name
}

output "lbc_iam_role_arn" {
  description = "The ARN of the IAM role for the Load Balancer Controller"
  value       = module.lbc.lbc_iam_role_arn
}
