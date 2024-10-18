provider "aws" {
  region     = "ap-south-1"
}


terraform {

  backend "s3" {
    bucket = "terraform-be-worley-test"
    key = "terraform-be-worley-test/terraform.tfstate"
    region = "ap-south-1"
  }
}