variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets to use for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "desired_capacity" {
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

variable "instance_type" {
  description = "The EC2 instance type for EKS nodes"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts (IRSA)"
  type        = bool
  default     = true
}
