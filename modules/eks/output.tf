output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  value = module.eks.cluster.certificate_authority[0].data
}
