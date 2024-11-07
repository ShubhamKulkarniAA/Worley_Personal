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
