# IAM role for AWS Load Balancer Controller
resource "aws_iam_role" "lbc_role" {
  name = "aws-lbc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach necessary policies to the IAM role for Load Balancer Controller
resource "aws_iam_role_policy_attachment" "lbc_AmazonEKSLoadBalancerControllerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLoadBalancerControllerPolicy"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonVPCFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonElasticLoadBalancingFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticLoadBalancingFullAccess"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.lbc_role.name
}

resource "aws_iam_role_policy_attachment" "lbc_AmazonEC2FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.lbc_role.name
}

# Fetch EKS cluster details
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
