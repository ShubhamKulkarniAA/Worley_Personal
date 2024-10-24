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

# Add the missing variables here
variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

variable "alb_ingress_role_name" {
  description = "IAM role name for the ALB Ingress Controller"
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}
