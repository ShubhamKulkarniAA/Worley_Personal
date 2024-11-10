locals {
  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 30 days"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["latest"]
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# Create the ECR repositories using a loop

resource "aws_ecr_repository" "ecr_repo" {
  for_each            = toset(var.repository_names)
  name                = each.value
  image_tag_mutability = var.image_tag_mutability
  tags                = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

# Create ECR lifecycle policies for each repository

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle" {
  for_each   = toset(var.repository_names)
  repository = aws_ecr_repository.ecr_repo[each.value].name
  policy     = local.lifecycle_policy
}
