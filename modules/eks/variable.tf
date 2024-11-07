# Variables for EKS Cluster and Node Group

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

variable "subnet_ids" {
  description = "The IDs of the subnets to use for the EKS cluster and node group"
  type        = list(string)
}

# Variables for the AWS Load Balancer Controller (ALB Ingress Controller)

variable "region" {
  description = "The AWS region where the EKS cluster and resources are deployed"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster and AWS Load Balancer Controller should be deployed"
  type        = string
}
