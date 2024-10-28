module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
  eks_cluster_sg_id = module.eks.cluster_security_group_id
}

module "alb" {
  source = "./modules/alb"
  public_alb_name = var.public_alb_name
  vpc_id = module.vpc.vpc_id
  public_subnet1 = module.vpc.public_subnet1_id
  public_subnet2 = module.vpc.public_subnet2_id
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  public_subnet1 = module.vpc.public_subnet1_id
  public_subnet2 = module.vpc.public_subnet2_id
  node_group_name = "${var.cluster_name}-node-group"
}

module "ecr" {
  source              = "./modules/ecr"
  repository_name     = "demo-worley-nc-ecr"
  image_tag_mutability = "MUTABLE"
}
