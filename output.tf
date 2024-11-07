#VPC Output
output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.vpc_id
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


#ALB Output
output "public_alb_arn" {
  value = module.alb.public_alb_arn
}

output "public_alb_tg_arn" {
  value = module.alb.public_alb_tg_arn
}


#ECR Output
output "repository_uri" {
  description = "URI of the ECR repository"
  value       = module.ecr.repository_uri
}

output "repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}


#EKS Output
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
