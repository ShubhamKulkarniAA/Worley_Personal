resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn"              = aws_iam_role.lbc_role.arn
      "meta.helm.sh/release-name"               = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace"          = "kube-system"
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = local.aws_lbc_version  # If using the version locally or passed dynamically

  force_update = true   # Force a replacement if the version changes (ensures upgrade)

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"  # We don't want Helm to create the ServiceAccount, it's already created by Terraform
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment
  ]
}
