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

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  region             = var.region
  subnet_ids         = [module.vpc.public_subnet1_id, module.vpc.public_subnet2_id, module.vpc.private_subnet1_id, module.vpc.private_subnet2_id]
  private_subnet1_id = module.vpc.private_subnet1_id
  private_subnet2_id = module.vpc.private_subnet2_id
  depends_on         = [module.vpc]
}

module "lbc" {
  source            = "./modules/lbc"
  cluster_name      = module.eks.cluster_name
  region            = var.region
  oidc_provider_arn = module.eks.cluster_oidc_provider_arn
  oidc_provider_url = module.eks.cluster_oidc_provider_url
  cluster_endpoint  = module.eks.cluster_endpoint
  depends_on        = [module.eks]
}
