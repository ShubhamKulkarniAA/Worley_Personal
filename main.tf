module "vpc" {
  source                   = "./modules/vpc"
  region                   = var.region
  vpc_cidr                 = var.vpc_cidr
  vpc_name                 = var.vpc_name
  internet_gateway_name    = var.internet_gateway_name
  public_subnet1_cidr      = var.public_subnet1_cidr
  public_subnet2_cidr      = var.public_subnet2_cidr
  private_subnet1_cidr     = var.private_subnet1_cidr
  private_subnet2_cidr     = var.private_subnet2_cidr
  private_rds_subnet1_cidr = var.private_rds_subnet1_cidr
  private_rds_subnet2_cidr = var.private_rds_subnet2_cidr
  availability_zone1       = var.availability_zone1
  availability_zone2       = var.availability_zone2
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  subnet_ids = [
    module.vpc.public_subnet1_id,
    module.vpc.public_subnet2_id,
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
  vpc_id           = module.vpc.vpc_id
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  instance_type    = var.instance_type
}

module "lbc" {
  source       = "./modules/lbc"
  cluster_name = module.eks.cluster_name
  region       = var.region
  eks_oidc_id  = module.eks.cluster_oidc_issuer_url
  vpc_id       = module.vpc.vpc_id
}

module "ecr" {
  source               = "./modules/ecr"
  repository_names     = var.repository_names
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags
}
