resource "helm_release" "aws_load_balancer_controller" {
  name         = "aws-load-balancer-controller"
  namespace    = "kube-system"
  chart        = "aws-load-balancer-controller"
  repository   = "https://aws.github.io/eks-charts"
  force_update = true # Ensures that Helm forces an update if the version changes

  # Set Helm chart values directly using the `set` argument
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
    value = "false" # Service account is already created in the above resource
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "webhookBindPort"
    value = "9443" # Default port for the webhook
  }

  replace = true # Force Helm to replace existing resources

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment,
    kubernetes_service_account.aws_load_balancer_controller
  ]
}
