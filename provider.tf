terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Adjust version as needed
    }
    eks = {
      source  = "hashicorp/eks"
      version = "~> 3.0"  # Adjust version as needed
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"  # Adjust version as needed
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

provider "eks" {
  region = var.region
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your kubeconfig file
  }
}
