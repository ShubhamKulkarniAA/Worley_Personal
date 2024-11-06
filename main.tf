module "vpc" {
  source = "./modules/vpc"
  region                    = var.region
  vpc_cidr                  = var.vpc_cidr
  vpc_name                  = var.vpc_name
  internet_gateway_name     = var.internet_gateway_name
  public_subnet1_cidr       = var.public_subnet1_cidr
  public_subnet2_cidr       = var.public_subnet2_cidr
  private_subnet1_cidr      = var.private_subnet1_cidr
  private_subnet2_cidr      = var.private_subnet2_cidr
  private_rds_subnet1_cidr  = var.private_rds_subnet1_cidr
  private_rds_subnet2_cidr  = var.private_rds_subnet2_cidr
  availability_zone1        = var.availability_zone1
  availability_zone2        = var.availability_zone2
}

module "alb" {
  source = "./modules/alb"
  public_alb_name        = var.public_alb_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet1         = module.vpc.public_subnet1_id
  public_subnet2         = module.vpc.public_subnet2_id
}

module "ecr" {
  source = "./modules/ecr"
  repository_names        = var.repository_names
  image_tag_mutability   = var.image_tag_mutability
  tags                   = var.tags
}

module "eks" {
  source                = "./modules/eks"
  region                = var.region
  cluster_name          = var.cluster_name
  cluster_role_arn      = module.eks.cluster_role_arn
  node_role_arn         = module.eks.node_role_arn
  node_group_name       = var.node_group_name
  desired_size          = var.desired_size
  max_size              = var.max_size
  min_size              = var.min_size
  public_subnet1        = module.vpc.public_subnet1_id
  public_subnet2        = module.vpc.public_subnet2_id
  private_subnet1       = module.vpc.private_subnet1_id
  private_subnet2       = module.vpc.private_subnet2_id
  namespace             = var.namespace
  service_account_name  = var.service_account_name
  fargate_profile_name  = var.fargate_profile_name
  eks_fargate_role_arn  = module.eks.eks_fargate_role_arn
}

/*module "lbc" {
  source                    = "./modules/lbc"
  cluster_name              = var.cluster_name
  namespace                 = var.namespace
  service_account_name      = var.service_account_name
  lbc_iam_role_arn          = module.eks.eks_fargate_role_arn
  lbc_namespace             = "kube-system"
  lbc_service_account_name  = "aws-load-balancer-controller"
  providers = {
    kubernetes = kubernetes
  }
}*/
