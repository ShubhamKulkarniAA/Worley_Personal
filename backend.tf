terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket-name"
    key    = "terraform.tfstate"
    region = "ap-south-1" # Replace with your desired region
  }
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "my-tfstate-bucket-name"
}
