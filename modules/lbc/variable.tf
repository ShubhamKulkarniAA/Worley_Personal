# variables.tf

variable "cluster_name" {
  description = "The name of the EKS cluster"
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

variable "oidc_thumbprint" {
  description = "The thumbprint of the OIDC certificate"
  type        = string
  default     = ""  # Empty default to allow dynamic fetching or manual input
}

variable "aws_account_id" {
  description = "The AWS account ID where the EKS cluster is located"
  type        = string
  default     = ""  # Set to an empty string, it will be populated in the main.tf
}

variable "eks_oidc_provider_id" {
  description = "The OIDC provider ID for the EKS cluster"
  type        = string
  default     = ""  # Set to an empty string, it will be populated in the main.tf
}

variable "cluster_role_arn" {
  description = "The ARN of the EKS cluster role."
  type        = string
}

variable "node_role_arn" {
  description = "The ARN of the IAM role to use for the EKS node group"
  type        = string
}
