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

# ALB Outputs
output "public_alb_arn" {
  value = module.alb.public_alb_arn
}

output "public_alb_tg_arn" {
  value = module.alb.public_alb_tg_arn
}

output "private_alb_arn" {
  value = module.alb.private_alb_arn
}

output "private_alb_tg_arn" {
  value = module.alb.private_alb_tg_arn
}

output "private_nlb_arn" {
  value = module.alb.private_nlb_arn
}

output "private_nlb_tg_arn" {
  value = module.alb.private_nlb_tg_arn
}

#adding EKS modules

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_ca_certificate" {
  description = "The CA certificate for the EKS cluster"
  value       = module.eks.eks_cluster_ca_certificate_authority[0].data
}

/*output "ecr_repository_url" {
 value = module.eks.ecr_repository_url
}*/
