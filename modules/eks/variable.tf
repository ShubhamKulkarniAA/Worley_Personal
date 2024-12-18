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
