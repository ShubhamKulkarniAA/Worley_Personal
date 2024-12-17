module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  version      = "~> 20.0"
  subnet_ids   = var.subnet_ids
  vpc_id       = var.vpc_id

  # Defining node groups correctly
  eks_managed_node_groups = {
    eks_nodes = {
      node_group_name  = var.node_group_name
      desired_capacity = var.desired_capacity
      max_size         = var.max_size
      min_size         = var.min_size
      instance_type    = var.instance_type

    }
  }

  enable_irsa = true

  tags = {
    cluster = "Prod EKS Cluster"
  }
}
