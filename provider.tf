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
