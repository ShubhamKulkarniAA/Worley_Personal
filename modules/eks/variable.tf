variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "private_ap_south_1a" {
  description = "ID of the private subnet in ap-south-1a"
  type        = string
}

variable "private_ap_south_1b" {
  description = "ID of the private subnet in ap-south-1b"
  type        = string
}

variable "public_ap_south_1a" {
  description = "ID of the public subnet in ap-south-1a"
  type        = string
}

variable "public_ap_south_1b" {
  description = "ID of the public subnet in ap-south-1b"
  type        = string
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

# New variable for ECR repository name
/*variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}*/
