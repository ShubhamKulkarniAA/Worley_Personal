# Kubernetes Service Account for AWS Load Balancer Controller
resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}

# IRSA: Associate the Kubernetes Service Account with the IAM Role for AWS Load Balancer Controller
resource "aws_eks_cluster_auth" "eks_cluster_auth" {
  cluster_name = var.cluster_name
  role_arn     = aws_iam_role.aws_load_balancer_controller.arn
}
