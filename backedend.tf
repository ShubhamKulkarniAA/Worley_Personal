terraform {
  backend "s3" {
    bucket         = "demo-terraform-be-worley-test"     
    key            = "demo-terraform-be-worley-test/terraform.tfstate" 
    region         = "us-south-1"               
    encrypt        = true                        # Encrypt state file at rest
    dynamodb_table = "demo-Worley-NC"      # Optional: For state locking
  }
}