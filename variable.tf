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

/*variable "public_alb_name" {
  type = string
}

variable "private_alb_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet1" {
  type = string
}

variable "public_subnet2" {
  type = string
}

variable "private_subnet1" {
  type = string
}

variable "private_subnet2" {
  type = string
}

variable "public_eks_cidr" {
  type = string
}

variable "private_eks_cidr" {
  type = string
}

variable "api_gateway_cidr" {
  type = string
}

variable "public_eks_name" {
  type = string
}

variable "private_eks_name" {
  type = string
}

variable "private_subnets" {
  type = string
}

variable "public_subnets" {
  type = string
}*/

# EKS Module Variables

variable "cluster_name" {
  description = "EKS Cluster name"
  type = string
}

variable "public_eks_cidr" {
  description = "List of subnet IDs for the EKS cluster"
  type = string
  }

variable "node_group_name" {
  description = "EKS Node Group name"
  type = string
}

variable "subnet_ids" {
  type = string
}
