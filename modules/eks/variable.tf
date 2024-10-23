variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

variable "alb_ingress_role_name" {
  description = "IAM role name for the ALB Ingress Controller"
  type        = string
}

# New variable for ECR repository name

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "ecr_policy_name" {
  description = "Name for the ECR access policy"
  type        = string
  default     = "${var.cluster_name}-ecr-access-policy"
}
