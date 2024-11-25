# Kubernetes Service Account for the Load Balancer Controller
resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lbc_role.arn
    }
  }
}

# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name         = "aws-load-balancer-controller"
  namespace    = "kube-system"
  chart        = "aws-load-balancer-controller"
  repository   = "https://aws.github.io/eks-charts"
  force_update = true

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "serviceAccount.create"
    value = "false" # Service account is already created manually
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_load_balancer_controller.metadata[0].name # Reference the service account
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "webhookBindPort"
    value = "9443" # Default webhook port
  }

  set {
    name  = "controller.ingressClass"
    value = "alb"
  }

  replace = true # Forces Helm to replace existing resources

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment,
    kubernetes_service_account.aws_load_balancer_controller
  ]
}
