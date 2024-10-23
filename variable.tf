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
variable "private_alb_name" {
  type = string
}
/*variable "certificate_arn" {
  type = string
}*/
variable "private_eks_cidr" {
    type = string
}
variable "public_eks_cidr" {
    type = string
}
variable "api_gateway_cidr" {
    type = string
}
variable "private_nlb_name" {
  type = string
}

# EKS Module Variables


variable "cluster_name" {
  description = "EKS Cluster name"
  type = string
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "alb_ingress_role_name" {
  description = "IAM role name for the ALB Ingress Controller"
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repositor"
  type        = string
}

variable "ecr_policy_name" {
  description = "Name for the ECR access policy"
  type        = string
  default     = "${var.cluster_name}-ecr-access-policy"
}
