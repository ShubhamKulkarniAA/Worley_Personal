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
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = [module.vpc.public_subnet1_id, module.vpc.public_subnet2_id]
}

module "lbc" {
  source       = "./modules/lbc"
  cluster_name = module.eks.cluster_name
  depends_on   = [module.eks]
}
