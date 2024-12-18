terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket = "my-tfstate-bucket-name"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "my-tfstate-bucket-name"
  region = "ap-south-1"
}
