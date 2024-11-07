output "repository_uri" {
  description = "URI of the ECR repository"
  value       = aws_ecr_repository.ecr_repo.repository_url
}

output "repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.ecr_repo.name
}
