output "vpc_id" {
  description = "The VPC ID"
  value = module.vpc.vpc_id
}

output "public_subnet1_id" {
  value = module.vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.vpc.public_subnet2_id
}

# ALB Outputs

output "public_alb_arn" {
  value = module.alb.public_alb_arn
}

output "public_alb_tg_arn" {
  value = module.alb.public_alb_tg_arn
}

#adding EKS modules

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_ca_certificate" {
  value = module.eks.eks_cluster_ca_certificate
}
