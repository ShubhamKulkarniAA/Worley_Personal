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

# Fetch the EKS Cluster details
data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.name
}

# Fetch the EKS Cluster Authentication Token
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.name
}

# Kubernetes provider configuration
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}
