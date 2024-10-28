terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75.0"
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

resource "aws_api_gateway_rest_api" "public_api" {
  name        = "example"
  description = "Example API"

}
