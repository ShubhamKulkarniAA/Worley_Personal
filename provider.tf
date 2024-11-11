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
