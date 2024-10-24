variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "public_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet2" {
  description = "The ID of the second public subnet"
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
