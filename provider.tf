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

# Fetch the authentication token for the EKS cluster (Ensure EKS cluster exists before this)
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

# Kubernetes provider configuration
provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


# Helm provider configuration
provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
