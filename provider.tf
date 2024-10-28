terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # or a specific version like "5.73.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}


terraform {

  backend "s3" {
    bucket = "demo-terraform-be-worley-test"
    key = "demo-terraform-be-worley-test/terraform.tfstate"
    region = "ap-south-1"
  }
}
