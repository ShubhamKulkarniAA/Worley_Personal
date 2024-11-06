output "repository_names" {
  description = "The names of the created ECR repositories"
  value       = aws_ecr_repository.ecr_repo[*].name
}

output "repository_arn" {
  description = "The ARNs of the created ECR repositories"
  value       = aws_ecr_repository.ecr_repo[*].arn
}

output "repository_urls" {
  description = "The repository URLs of the created ECR repositories"
  value       = aws_ecr_repository.ecr_repo[*].repository_url
}

output "lifecycle_policy" {
  description = "The lifecycle policies applied to the repositories"
  value       = aws_ecr_lifecycle_policy.ecr_lifecycle[*].policy
}
