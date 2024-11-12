# IAM Role for EKS Cluster
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

# Attach the policy to EKS cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# IAM Role for EKS Node
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

# Attach required policies for the node role
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

# Additional policy for accessing ECR (if using ECR for images)
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# EKS Cluster definition
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# Define Launch Template for EKS Node Group
resource "aws_launch_template" "eks_node_launch_template" {
  name_prefix   = "eks-node-template"
  instance_type = var.instance_type
  key_name      = var.ec2_key_name

  metadata_options {
    http_tokens               = "required"
    http_put_response_hop_limit = 2
    http_endpoint             = "enabled"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  launch_template {
    id      = aws_launch_template.eks_node_launch_template.id
    version = "$Latest"
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

# Fetch IMDS token and authenticate using a local-exec provisioner
resource "null_resource" "fetch_imds_token" {
  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash

# Request an IMDSv2 token
echo "Requesting IMDSv2 token..."
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
-H "Content-Length: 0")

if [ -z "$TOKEN" ]; then
  echo "Error: Failed to fetch IMDSv2 token"
  exit 1
fi
echo "Token fetched successfully: $TOKEN"

# Fetch Instance ID and Region using the token
echo "Fetching Instance ID..."
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

if [ -z "$INSTANCE_ID" ]; then
  echo "Error: Failed to fetch Instance ID"
  exit 1
fi
echo "Instance ID: $INSTANCE_ID"

echo "Fetching Region..."
REGION=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/region)

if [ -z "$REGION" ]; then
  echo "Error: Failed to fetch Region"
  exit 1
fi
echo "Region: $REGION"

# Verify AWS STS identity (optional, to confirm permissions)
echo "Verifying AWS STS identity..."
aws sts get-caller-identity --region $REGION
EOT
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}
