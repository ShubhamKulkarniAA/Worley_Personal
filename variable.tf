# VPC Variables
variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "availability_zone1" {
  type = string
}

variable "public_subnet2_cidr" {
  type = string
}

variable "availability_zone2" {
  type = string
}

variable "private_subnet1_cidr" {
  type = string
}

variable "private_subnet2_cidr" {
  type = string
}

variable "private_rds_subnet1_cidr" {
  type = string
}

variable "private_rds_subnet2_cidr" {
  type = string
}

variable "region" {
  type = string
}

# ALB Variables
variable "public_alb_name" {
  type = string
}

# ECR Variables
variable "repository_names" {
  type        = list(string)
  description = "List of ECR repository names to be created (e.g., UI and API)"
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "tags" {
  type    = map(string)
  default = {}
}

# EKS Variables
variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "namespace" {
  description = "The Kubernetes namespace for the service account"
  type        = string
}

variable "service_account_name" {
  description = "The name of the service account"
  type        = string
}

variable "oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "fargate_profile_name" {
  description = "The name of the EKS Fargate profile"
  type        = string
}

#LBC Variable
variable "lbc_namespace" {
  description = "The namespace where the Load Balancer Controller will be deployed"
  type        = string
  default     = "kube-system"
}

variable "lbc_service_account_name" {
  description = "The name of the Service Account for the Load Balancer Controller"
  type        = string
  default     = "aws-load-balancer-controller"
}
