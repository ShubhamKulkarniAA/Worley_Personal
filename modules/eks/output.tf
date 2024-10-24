output "eks_cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

# Output for ECR repository URL
/*output "ecr_repository_url" {
  value = aws_ecr_repository.app1.repository_url
}*/
