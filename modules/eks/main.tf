module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  subnets      = var.subnets
  vpc_id       = var.vpc_id

  # Defining node groups correctly
  node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_size         = var.max_size
      min_size         = var.min_size
      instance_type    = var.instance_type
      name             = var.node_group_name
    }
  }

  cluster_oidc_enabled = true
}
