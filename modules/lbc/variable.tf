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

data "aws_caller_identity" "current" {}

variable "aws_account_id" {
  description = "The AWS account ID where the EKS cluster is located"
  type        = string
  default     = data.aws_caller_identity.current.account_id
}

variable "eks_oidc_provider_id" {
  description = "The OIDC provider ID for the EKS cluster"
  type        = string
  default     = split("/", data.aws_eks_cluster.eks.identity[0].oidc[0].issuer)[5]
}
