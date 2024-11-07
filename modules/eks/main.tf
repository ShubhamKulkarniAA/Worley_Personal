resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

# Fetch the OIDC certificate for the URL of the EKS cluster
data "tls_certificate" "oidc_cert" {
  url = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url             = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_cert.cert_fingerprint]

  depends_on = [aws_eks_cluster.eks_cluster]
}


resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# ALB Ingress Controller - IAM Role & Policy
resource "aws_iam_role" "alb_ingress_controller" {
  name = "alb-ingress-controller"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "alb_ingress_controller_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSALBIngressControllerPolicy"
  role       = aws_iam_role.alb_ingress_controller.name
}

# Kubernetes Service Account for ALB Ingress Controller
resource "kubernetes_service_account" "alb_ingress_controller" {
  metadata {
    name      = "alb-ingress-controller"
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_ingress_controller.arn
    }
  }
}

# Helm Release for ALB Ingress Controller
resource "helm_release" "alb_ingress_controller" {
  name       = "aws-alb-ingress-controller"
  namespace  = var.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "alb-ingress-controller"
  version    = "1.1.8"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "ingressClass"
    value = var.ingress_class
  }

  set {
    name  = "autoDiscoverAwsVpcID"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.alb_ingress_controller.metadata[0].name
  }

  set {
    name  = "serviceAccount.annotations.eks.amazonaws.com/role-arn"
    value = aws_iam_role.alb_ingress_controller.arn
  }
}

data "aws_region" "current" {}
