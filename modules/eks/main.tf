resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.cluster_name}-node-group-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

# IAM Policy for ECR
resource "aws_iam_policy" "ecr_access_policy" {
  name        = "${var.cluster_name}-ecr-access-policy"
  description = "Policy for EKS Node Group to access ECR"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_access_role_attachment" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t2.micro"]
  capacity_type   = "ON_DEMAND"
}

# IAM Policy for ALB ingress controller
resource "aws_iam_policy" "alb_ingress_policy" {
  name        = "${var.cluster_name}-alb-ingress-policy"
  description = "Policy for ALB Ingress Controller"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticloadbalancing:*",
          "ec2:Describe*",
          "iam:ListServerCertificates",
          "iam:GetServerCertificate",
          "acm:ListCertificates",
          "acm:DescribeCertificate",
          "tag:GetResources",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutMetricData",
          "autoscaling:*",
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Attach ALB ingress role

resource "aws_iam_role" "alb_ingress_role" {
  name = var.alb_ingress_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "elasticloadbalancing.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "alb_ingress_role_policy_attachment" {
  role       = aws_iam_role.alb_ingress_role.name
  policy_arn = aws_iam_policy.alb_ingress_policy.arn
}
