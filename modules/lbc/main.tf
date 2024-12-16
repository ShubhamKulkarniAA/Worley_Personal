resource "aws_iam_policy" "aws_lb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for the AWS Load Balancer Controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticloadbalancing:*",
          "ec2:Describe*",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:CreateTags",
          "ec2:DescribeInstances",
          "ec2:DeleteSecurityGroup",
          "ec2:ModifyInstanceAttribute",
          "iam:ListInstanceProfiles",
          "iam:GetRole",
          "iam:ListRoles",
          "iam:GetRolePolicy",
          "iam:AttachRolePolicy",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "eks:DescribeCluster"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "aws_lb_controller_role" {
  name = "aws-load-balancer-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_eks_cluster.cluster.cluster_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_oidc_id}"
        }
        Effect = "Allow"
        Condition = {
          StringEquals = {
            "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_oidc_id}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_policy_attachment" {
  policy_arn = aws_iam_policy.aws_lb_controller_policy.arn
  role       = aws_iam_role.aws_lb_controller_role.name
}

resource "kubernetes_service_account" "aws_lb_controller_sa" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
  automount_service_account_token = true
}

resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false" # We are using the existing service account created above
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_lb_controller_sa.metadata[0].name
  }

  set {
    name  = "region"
    value = var.region
  }
}
