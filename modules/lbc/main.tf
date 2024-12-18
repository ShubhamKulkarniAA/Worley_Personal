data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller-${var.cluster_name}"]
    }
    principals {
      identifiers = [module.eks.cluster_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "kubernetes_namespace" "aws_load_balancer_controller" {
  metadata {
    name = "kube-system"
  }
}

resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = kubernetes_namespace.aws_load_balancer_controller.metadata[0].name
  }
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name               = "AWSLoadBalancerControllerIAMRole"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_policy_attachment" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLoadBalancerControllerIAMPolicy2023"
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = kubernetes_namespace.aws_load_balancer_controller.metadata[0].name
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.5"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = "false" # Already created above
  }
  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_load_balancer_controller.metadata[0].name
  }

  depends_on = [
    aws_iam_role_policy_attachment.aws_load_balancer_controller_policy_attachment,
    kubernetes_service_account.aws_load_balancer_controller,
    kubernetes_namespace.aws_load_balancer_controller,
  ]
}
