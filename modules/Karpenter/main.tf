# Karpenter Controller Role
resource "aws_iam_role" "karpenter_controller_role" {
  name               = "karpenter-controller-role"
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json

  provisioner "local-exec" {
    command = "echo 'Karpenter controller role created successfully'"
  }
}

# Karpenter Controller Policy
resource "aws_iam_policy" "karpenter_controller_policy" {
  name        = "karpenter-controller-policy"
  description = "Policy for Karpenter controller"
  policy      = data.aws_iam_policy_document.karpenter_controller_policy.json

  provisioner "local-exec" {
    command = "echo 'Karpenter controller policy created successfully'"
  }
}

# Attach Karpenter Controller Policy to Role
resource "aws_iam_role_policy_attachment" "karpenter_controller_policy_attach" {
  role       = aws_iam_role.karpenter_controller_role.name
  policy_arn = aws_iam_policy.karpenter_controller_policy.arn

  provisioner "local-exec" {
    command = "echo 'Policy attached to Karpenter controller role'"
  }
}

# Karpenter Node Role (for EC2 instances)
resource "aws_iam_role" "karpenter_instance_role" {
  name = "karpenter-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })

  provisioner "local-exec" {
    command = "echo 'Karpenter node role created successfully'"
  }
}

# Karpenter Instance Profile (for EC2 instances)
resource "aws_iam_instance_profile" "karpenter_instance_profile" {
  name = "karpenter-instance-profile"
  role = aws_iam_role.karpenter_instance_role.name

  provisioner "local-exec" {
    command = "echo 'Karpenter instance profile created successfully'"
  }
}

# Helm Release for Karpenter
resource "helm_release" "karpenter" {
  name         = "karpenter"
  namespace    = kubernetes_namespace.karpenter.metadata[0].name
  chart        = "karpenter"
  repository   = "https://charts.karpenter.sh"
  version      = "0.16.3"
  force_update = true

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.karpenter_controller.metadata[0].name
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "clusterEndpoint"
    value = data.aws_eks_cluster.eks_cluster.endpoint
  }

  set {
    name  = "defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter_instance_profile.name
  }

  depends_on = [
    aws_iam_role_policy_attachment.karpenter_controller_policy_attach,
    aws_iam_instance_profile.karpenter_instance_profile,
    kubernetes_service_account.karpenter_controller,
  ]

  provisioner "local-exec" {
    command = "echo 'Karpenter Helm chart deployed successfully'"
  }
}

# Karpenter Namespace
resource "kubernetes_namespace" "karpenter" {
  metadata {
    name = "karpenter"
  }

  provisioner "local-exec" {
    command = "echo 'Karpenter namespace created successfully'"
  }
}

# Karpenter Service Account
resource "kubernetes_service_account" "karpenter_controller" {
  metadata {
    name      = "karpenter-controller"
    namespace = kubernetes_namespace.karpenter.metadata[0].name
  }

  provisioner "local-exec" {
    command = "echo 'Karpenter service account created successfully'"
  }
}

# EKS Cluster Data Source
data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

# Karpenter Controller Assume Role Policy Document
data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

# Karpenter Controller IAM Policy
data "aws_iam_policy_document" "karpenter_controller_policy" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "iam:PassRole",
      "sts:AssumeRole",
      "ssm:GetParameter",  # Permission to get SSM parameter for AMI
      "ec2:DescribeSubnets",  # Permission to describe EC2 subnets
      "ec2:DescribeSpotPriceHistory",
      "pricing:GetProducts",
      "ec2:DescribeLaunchTemplates"  # Allow Spot Instance pricing checks
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [
      "arn:aws:ssm:ap-south-1::parameter/aws/service/eks/optimized-ami/1.31/amazon-linux-2/recommended/image_id",
      "arn:aws:ssm:ap-south-1::parameter/aws/service/eks/optimized-ami/latest/amazon-linux-2/recommended/image_id"
    ]
  }
}
