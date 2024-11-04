variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role to use for the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "node_role_arn" {
  description = "The ARN of the IAM role to use for the EKS node group"
  type        = string
}

variable "desired_size" {
  description = "The desired number of nodes in the EKS node group"
  type        = number
}

variable "max_size" {
  description = "The maximum number of nodes in the EKS node group"
  type        = number
}

variable "min_size" {
  description = "The minimum number of nodes in the EKS node group"
  type        = number
}

variable "public_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet2" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "private_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "private_subnet2" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "region" {
  description = "The AWS region where the EKS cluster is located"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the service account"
  type        = string
}

variable "service_account_name" {
  description = "Name of the service account to use"
  type        = string
}

variable "fargate_profile_name" {
  description = "The name of the EKS Fargate profile"
  type        = string
}

variable "eks_fargate_role_arn" {
  description = "The ARN of the IAM role for Fargate"
  type        = string
}
