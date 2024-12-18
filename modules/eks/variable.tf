variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

variable "subnet_ids" {
  description = "The IDs of the subnets to use for the EKS cluster and node group"
  type        = list(string)
}
