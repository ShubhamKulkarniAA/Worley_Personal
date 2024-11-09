# Kubernetes Service Account for AWS Load Balancer Controller
resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lbc_role.arn
      "meta.helm.sh/release-name"  = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }

  depends_on = [aws_iam_role.lbc_role]  # Ensure IAM role is created before the service account
}

# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-lbc-service-account"
  namespace  = "kube-system"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"

  force_update = true  # Ensures that Helm forces an update if the version changes

  # Setting values for the Helm chart
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id  # Make sure the correct VPC ID is set, as required by the controller
  }

  replace = true  # Force Helm to replace existing resources if needed

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment,  # Ensure the IAM role policy is attached first
    kubernetes_service_account.aws_load_balancer_controller         # Ensure the service account is created first
  ]
}
