# Fetch AWS caller identity (current account)
data "aws_caller_identity" "current" {}

# Fetch the EKS cluster details
data "aws_eks_cluster" "eks" {
  depends_on = [ module.eks_cluster.eks_cluster ]
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  depends_on = [ module.eks_cluster.eks_cluster  ]
  name = var.cluster_name
}

# Fetch OIDC certificate thumbprint dynamically from the EKS OIDC URL
data "tls_certificate" "eks_cluster" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

# Local to extract OIDC provider ID from the EKS issuer URL
locals {
  eks_oidc_provider_id = split("/", data.aws_eks_cluster.eks.identity[0].oidc[0].issuer)[length(split("/", data.aws_eks_cluster.eks.identity[0].oidc[0].issuer)) - 1]
}

# Set up the OIDC identity provider for the EKS cluster using dynamic thumbprint
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  # Dynamically set the thumbprint if not provided in the variable
  thumbprint_list = var.oidc_thumbprint != "" ? [var.oidc_thumbprint] : [data.tls_certificate.eks_cluster.certificates[0].sha1_fingerprint]
}

# IAM policy for the Load Balancer Controller (LBC)
resource "aws_iam_policy" "lbc_custom_policy" {
  name        = "aws-lbc-custom-policy"
  description = "Minimal policy for AWS Load Balancer Controller to manage resources"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": ["iam:CreateServiceLinkedRole"],
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "iam:AWSServiceName": "elasticloadbalancing.amazonaws.com"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeTags",
          "ec2:GetCoipPoolUsage",
          "ec2:DescribeCoipPools",
          "ec2:GetSecurityGroupsForVpc",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeListenerCertificates",
          "elasticloadbalancing:DescribeSSLPolicies",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTrustStores",
          "elasticloadbalancing:DescribeListenerAttributes",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "cognito-idp:DescribeUserPoolClient",
          "acm:ListCertificates",
          "acm:DescribeCertificate",
          "iam:ListServerCertificates",
          "iam:GetServerCertificate",
          "waf-regional:GetWebACL",
          "waf-regional:GetWebACLForResource",
          "waf-regional:AssociateWebACL",
          "waf-regional:DisassociateWebACL",
          "wafv2:GetWebACL",
          "wafv2:GetWebACLForResource",
          "wafv2:AssociateWebACL",
          "wafv2:DisassociateWebACL",
          "shield:GetSubscriptionState",
          "shield:DescribeProtection",
          "shield:CreateProtection",
          "shield:DeleteProtection"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateSecurityGroup"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateTags"
        ],
        "Resource": "arn:aws:ec2:*:*:security-group/*",
        "Condition": {
          "StringEquals": {
            "ec2:CreateAction": "CreateSecurityGroup"
          },
          "Null": {
            "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
          }
        }
      },
      # Add additional policy statements here as required
    ]
  })
}

# IAM Role for AWS Load Balancer Controller
resource "aws_iam_role" "lbc_role" {
  name = "aws-lbc-role"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect"    = "Allow",
        "Action"    = "sts:AssumeRoleWithWebIdentity",
        "Principal" = {
          "Federated" = format("arn:aws:iam::%s:oidc-provider/oidc.eks.%s.amazonaws.com/id/%s", data.aws_caller_identity.current.account_id, var.region, local.eks_oidc_provider_id)
        },
        "Condition" = {
          "StringEquals" = {
            format("oidc.eks.%s.amazonaws.com/id/%s:sub", var.region, local.eks_oidc_provider_id) = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      },
      {
        "Effect"    = "Allow",
        "Principal" = {
          "Service" = "elasticloadbalancing.amazonaws.com"
        },
        "Action"    = "sts:AssumeRole"
      }
    ]
  })

  depends_on = [aws_iam_openid_connect_provider.eks_oidc_provider]  # Ensure OIDC provider is created before role
}

# Attach the custom IAM policy to the LBC role
resource "aws_iam_role_policy_attachment" "lbc_custom_policy_attachment" {
  policy_arn = aws_iam_policy.lbc_custom_policy.arn
  role       = aws_iam_role.lbc_role.name

  depends_on = [aws_iam_role.lbc_role]  # Ensure the IAM role is created before attaching the policy
}
