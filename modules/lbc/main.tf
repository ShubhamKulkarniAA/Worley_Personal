# IAM Policy Document for Load Balancer Controller assume role policy
data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller-${module.eks.cluster_name}"]
    }
    principals {
      identifiers = [module.eks.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

# IAM Role for the Load Balancer Controller
resource "aws_iam_role" "lbc_role" {
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role_policy.json
  name               = "aws-load-balancer-controller-${module.eks.cluster_name}"
}

resource "aws_iam_policy" "lbc_custom_policy" {
  name = "AWSLoadBalancerController-${module.eks.cluster_name}"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:SetSecurityGroups",
          "elasticloadbalancing:SetSubnets",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:ModifyTargetGroup",
          "elasticloadbalancing:DeleteTargetGroup"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole",
          "iam:ListServerCertificates",
          "iam:GetServerCertificate"
        ],
        "Resource" : "*"
      }
    ]
  })
}

# IAM Role Policy Attachment for the Load Balancer Controller
resource "aws_iam_role_policy_attachment" "lbc_role_policy_attachment" {
  role       = aws_iam_role.lbc_role.name
  policy_arn = aws_iam_policy.lbc_custom_policy.arn
}

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
