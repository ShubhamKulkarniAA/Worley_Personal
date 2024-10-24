output "eks_cluster_name" {
  description = "The name of the EKS Cluster"
  value       = aws_eks_cluster.cluster.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS Cluster"
  value       = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "The CA certificate for the EKS Cluster"
  value       = aws_eks_cluster.cluster.certificates[0]
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.app.repository_url
}

output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.app.name
}
