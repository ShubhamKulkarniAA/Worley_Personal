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
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Helm provider for installing Loadbalancer controller.
provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--profile", "labs", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}
