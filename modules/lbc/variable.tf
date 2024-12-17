variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be created"
  type        = string
}

variable "eks_oidc_issuer_url" {
  description = "The OIDC issuer URL for the EKS cluster"
  type        = string
}
