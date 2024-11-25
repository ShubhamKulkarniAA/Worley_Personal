# Kubernetes Service Account for the Load Balancer Controller
resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lbc_role.arn
      "meta.helm.sh/release-name"  = "aws-load-balancer-controller"
    }
  }
}

# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name         = "aws-load-balancer-controller"
  namespace    = "kube-system"
  chart        = "aws-load-balancer-controller"
  repository   = "https://aws.github.io/eks-charts"
  force_update = true # Ensures that Helm forces an update if the version changes

  set {
    name  = "replicaCount"
    value = "1" # Set the number of replicas for the controller
  }

  set {
    name  = "clusterName"
    value = var.cluster_name # Make sure var.cluster_name is set
  }

  set {
    name  = "region"
    value = var.region # Set your AWS region
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
    value = var.vpc_id # Make sure var.vpc_id is set
  }

  set {
    name  = "webhookBindPort"
    value = "9443" # Default webhook port
  }

  set {
    name  = "controller.ingressClass"
    value = "alb" # Set ingress class to alb, adjust as per your needs
  }

  replace = true # Forces Helm to replace existing resources

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment, # Ensure IAM role policies are attached first
    kubernetes_service_account.aws_load_balancer_controller      # Ensure the service account is created first
  ]
}
