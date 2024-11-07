terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket = "demo-terraform-be-worley-test"
    key    = "demo-terraform-be-worley-test/terraform.tfstate"
    region = "ap-south-1"
  }
}


# Data source to get information about the existing EKS cluster
data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks_cluster.name  # Reference to the EKS cluster declared elsewhere
}

# Data source to get the authentication token for the EKS cluster
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.name  # Same here, referencing the existing cluster
}

# Kubernetes provider configuration using data from the existing EKS cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}
