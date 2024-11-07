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

# IAM OIDC Identity Provider for the EKS Cluster
resource "aws_eks_cluster_identity" "eks_oidc_identity" {
  cluster_name = var.cluster_name
}

resource "aws_iam_oidc_provider" "eks_oidc_provider" {
  url = "https://oidc.eks.${var.region}.amazonaws.com/id/${module.eks.eks_cluster_id}"

  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    "9e99a48a2f7b440c818a95f684327f88bdbcaec0" # OIDC certificate thumbprint
  ]
}
