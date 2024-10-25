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

variable "private_subnet1" {
  description = "ID of the public subnet in ap-south-1a"
  type        = string
}

variable "private_subnet2" {
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

variable "ssh_key_name" {
  default = "EKS"
}
