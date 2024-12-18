# VPC Outputs

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "vpc_arn" {
  description = "The VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "bucket_name_vpc" {
  description = "The name of the S3 bucket for VPC flow logs"
  value       = module.s3.bucket_name_vpc
}

output "bucket_name_vpc_arn" {
  description = "The ARN of the S3 bucket for VPC flow logs"
  value       = module.s3.bucket_name_vpc_arn
}

output "public_subnet1_id" {
  description = "The ID of the public subnet 1"
  value       = module.vpc.public_subnet1_id
}

output "public_subnet2_id" {
  description = "The ID of the public subnet 2"
  value       = module.vpc.public_subnet2_id
}

output "private_subnet1_id" {
  description = "The ID of the private subnet 1"
  value       = module.vpc.private_subnet1_id
}

output "private_subnet2_id" {
  description = "The ID of the private subnet 2"
  value       = module.vpc.private_subnet2_id
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
  description = "The ARN of the EKS cluster role"
  value       = module.eks.cluster_role_arn
}

output "eks_node_role_arn" {
  description = "The ARN of the EKS node role"
  value       = module.eks.node_role_arn
}
