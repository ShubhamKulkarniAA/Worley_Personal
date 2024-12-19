module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true
  enable_irsa                    = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = var.subnet_ids

  eks_managed_node_groups = {
    eks_nodegroup_1 = {
      min_size       = 1
      max_size       = 1
      desired_size   = 1
      instance_types = ["t3.medium"]

    }
  }
}
