variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "alb_security_groups" {
  description = "Security groups for the Application Load Balancer"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

# ECR Variables
variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "ecr_repository_uri" {
  description = "The URI of the ECR repository"
  type        = string
}

variable "ecr_access_policy" {
  description = "The IAM policy for ECR access"
  type        = string
}
