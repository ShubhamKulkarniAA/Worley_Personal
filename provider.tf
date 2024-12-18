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

# Declare the EKS Cluster data source
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

# Declare the EKS Cluster authentication data source
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
