resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags

  lifecycle {
    prevent_destroy = true
  }
}
/*
resource "aws_ecr_lifecycle_policy" "ecr_repo" {
  repository = aws_ecr_repository.ecr_repo.name
  policy     = jsonencode(var.lifecycle_policy)
}
*/
