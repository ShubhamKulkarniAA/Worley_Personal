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
  description = "The name of the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of nodes in the EKS node group."
  type        = number
}

variable "max_size" {
  description = "The maximum number of nodes in the EKS node group."
  type        = number
}

variable "min_size" {
  description = "The minimum number of nodes in the EKS node group."
  type        = number
}

variable "instance_type" {
  description = "The EC2 instance type for the EKS node group."
  type        = string
}

# LBC Variables
variable "eks_oidc_id" {
  description = "The OIDC ID for the EKS cluster."
  type        = string
}
