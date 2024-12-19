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

# Data source for EKS cluster authentication
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

# Provider for Kubernetes
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Provider for Helm
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.cluster_ca_certificate)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
