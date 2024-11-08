# variables.tf

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "new_version" {
  description = "The version of the AWS Load Balancer Controller Helm chart"
  type        = string
}

variable "should_replace" {
  description = "Whether to replace the Helm release (used for version changes)"
  type        = bool
  default     = false
}
