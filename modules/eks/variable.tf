variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "subnets" {
  description = "The subnets in which the EKS cluster will be created."
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be created."
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
