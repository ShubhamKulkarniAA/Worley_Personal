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

variable "public_subnet2_cidr" {
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

variable "availability_zone1" {
  type = string
}

variable "availability_zone2" {
  type = string
}

variable "region" {
  type = string
}

# EKS Variables
variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for the EKS cluster"
}
