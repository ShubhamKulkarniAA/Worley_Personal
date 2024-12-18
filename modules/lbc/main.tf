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
  name = "AWSLoadBalancerControllerIAMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity",
        Effect = "Allow",
        Principal = {
          Federated = module.eks.cluster_oidc_provider_arn
        },
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_provider_url, "https://", "")}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
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

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
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
