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

# Provider for Kubernetes
provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Data source for EKS cluster authentication
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
