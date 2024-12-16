module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  vpc_id       = var.vpc_id
  subnet_ids   = var.subnets # This should be subnet_ids, not subnets

  # Define node_groups correctly
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_size         = var.max_size
      min_size         = var.min_size
      instance_type    = var.instance_type
      name             = var.node_group_name
    }
  }

  enable_irsa = true

}
