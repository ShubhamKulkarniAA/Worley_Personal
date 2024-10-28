variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "public_subnet1" {
  description = "ID of the private subnet in ap-south-1a"
  type        = string
}

variable "public_subnet2" {
  description = "ID of the private subnet in ap-south-1b"
  type        = string
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

variable "ssh_key_name" {
  default = "EKS"
}
