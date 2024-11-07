terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket = "terraform-nc-bucket-test"
    key    = "terraform-nc-bucket-test/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
