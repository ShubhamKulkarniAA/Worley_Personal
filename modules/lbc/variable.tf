variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The namespace where the Load Balancer Controller will be deployed"
  type        = string
}

variable "service_account_name" {
  description = "The name of the Service Account for the Load Balancer Controller"
  type        = string
}

variable "lbc_namespace" {
  description = "The namespace where the Load Balancer Controller will be deployed"
  type        = string
  default     = "kube-system"
}

variable "lbc_service_account_name" {
  description = "The name of the Service Account for the Load Balancer Controller"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "lbc_iam_role_arn" {
  description = "The ARN of the IAM role for the Load Balancer Controller"
  type        = string
}
