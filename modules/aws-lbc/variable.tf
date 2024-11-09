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
