variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "oidc_provider_arn" {
  description = "The OIDC provider ARN for the EKS cluster."
  type        = string
}

variable "oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster."
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster."
  type        = string
}
