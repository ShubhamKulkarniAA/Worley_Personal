terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.7.1"
    }
  }
}
