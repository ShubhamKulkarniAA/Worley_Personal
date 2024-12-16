variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "region" {
  description = "The AWS region where the EKS cluster is deployed."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be created."
  type        = string
}


variable "eks_oidc_id" {
  description = "The OIDC ID for the EKS cluster."
  type        = string
}
