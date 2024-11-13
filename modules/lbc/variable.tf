variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "eks_oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster."
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster."
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
