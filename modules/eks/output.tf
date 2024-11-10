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

# Reference the EKS cluster output from the `module.eks`
module "eks" {
  source      = "./modules/eks"  # Adjust to the actual path of your EKS module
  cluster_name = var.cluster_name
  subnet_ids  = var.subnet_ids
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
