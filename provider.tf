terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket = "worley-nc-test-bucket"
    key    = "worley-nc-test-bucket/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.region
}

provider "tls" {}

# Fetch the AWS account ID using data source
data "aws_caller_identity" "current" {}

# Fetch EKS cluster details
data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

# Fetch the Kubernetes cluster authentication token
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

# Kubernetes Provider Configuration using module outputs
provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint  # Use output from the module
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority)  # Use output from the module
  token                  = data.aws_eks_cluster_auth.cluster.token  # Token will still come from data source
}

# Helm Provider Configuration using module outputs
provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint  # Use output from the module
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority)  # Use output from the module
    token                  = data.aws_eks_cluster_auth.cluster.token  # Token will still come from data source
  }
}
