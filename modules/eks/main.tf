module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Using the VPC module's outputs for subnet and VPC references
  subnet_ids = [
    module.vpc.public_subnet1_id,
    module.vpc.public_subnet2_id,
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
  vpc_id = module.vpc.vpc_id

  create_iam_role = true
  enable_irsa     = true

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      # Restrict worker nodes to private subnets
      subnet_ids = [
        module.vpc.private_subnet1_id,
        module.vpc.private_subnet2_id
      ]
    }
  }
}
