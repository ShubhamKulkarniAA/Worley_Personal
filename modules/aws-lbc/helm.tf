resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.10.0"  # Make sure this is a valid and correct version

  # Values to be set in the Helm chart
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  # Force the Helm release to be replaced if already exists
  replace = true

  # Ensure the IAM role policy attachment is applied before Helm release
  depends_on = [aws_iam_role_policy_attachment.lbc_custom_policy_attachment]

}
