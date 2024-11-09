data "external" "aws_lbc_version" {
  program = [
    "curl", "-s", "https://api.github.com/repos/kubernetes-sigs/aws-load-balancer-controller/releases/latest"
  ]
}

locals {
  # Decode the full output and ensure `tag_name` is a string
  aws_lbc_version = tostring(jsondecode(data.external.aws_lbc_version.result)["tag_name"])
  should_replace  = var.new_version != local.aws_lbc_version  # Compare the provided version and the fetched version
}

# Fetch the EKS cluster details

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

# Fetch OIDC certificate thumbprint dynamically from the EKS OIDC URL
data "tls_certificate" "eks_cluster" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

# Set up the OIDC identity provider for the EKS cluster using dynamic thumbprint
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.eks_cluster.certificates[0].sha1_fingerprint
  ]
}

# IAM role for AWS Load Balancer Controller
resource "aws_iam_role" "lbc_role" {
  name = "aws-lbc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRoleWithWebIdentity"
        Effect    = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
      }
    ]
  })
}

# Custom IAM policy for AWS Load Balancer Controller
resource "aws_iam_policy" "lbc_custom_policy" {
  name        = "AWSLoadBalancerControllerCustomPolicy"
  description = "Custom policy for AWS Load Balancer Controller with essential permissions"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "iam:CreateServiceLinkedRole"
        ],
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
          "ec2:Describe*",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:CreateListener",
          "elasticloadbalancing:DeleteListener",
          "elasticloadbalancing:CreateRule",
          "elasticloadbalancing:DeleteRule",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:RemoveTags"
        ],
        "Resource": [
          "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
          "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
        ]
      }
    ]
  })
}

# Attach the custom IAM policy to the LBC role
resource "aws_iam_role_policy_attachment" "lbc_custom_policy_attachment" {
  policy_arn = aws_iam_policy.lbc_custom_policy.arn
  role       = aws_iam_role.lbc_role.name
}
