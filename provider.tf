terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket = "demo-terraform-be-worley-test"
    key    = "demo-terraform-be-worley-test/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "kubernetes" {
  host                   = "https://${data.aws_eks_cluster.cluster.endpoint}"
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = "Worley-NC-EKS-Cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "Worley-NC-EKS-Cluster"
}
