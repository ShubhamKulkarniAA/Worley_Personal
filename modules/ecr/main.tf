resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

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

resource "aws_ecr_lifecycle_policy" "ecr_repo" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = local.lifecycle_policy
}
