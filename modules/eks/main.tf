module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  create_iam_role = true
}

resource "aws_eks_node_group" "default" {
  cluster_name    = module.eks.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = module.eks.node_iam_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_type]
  remote_access {
    ec2_ssh_key = var.ec2_key_name
  }
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  depends_on = [module.eks]
}
