terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket = "terraform-nc-bucket-test"
    key    = "terraform-nc-bucket-test/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "tls" {

}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name  # The name of your EKS cluster
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name  # The name of your EKS cluster
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
