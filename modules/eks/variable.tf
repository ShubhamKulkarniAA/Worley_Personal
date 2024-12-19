variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Cluster version"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = list(string)
}
