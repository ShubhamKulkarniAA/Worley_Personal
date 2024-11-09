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

# Optional: OIDC thumbprint to pass if dynamically fetching doesn't work
variable "oidc_thumbprint" {
  description = "The thumbprint of the OIDC certificate"
  type        = string
  default     = ""  # Empty default to allow dynamic fetching or manual input
}
