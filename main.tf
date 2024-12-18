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
  depends_on      = [module.vpc]
}

module "lbc" {
  source                             = "./modules/lbc"
  cluster_name                       = module.eks.cluster_name
  oidc_provider_arn                  = module.eks.cluster_oidc_provider_arn
  oidc_provider_url                  = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  cluster_endpoint                   = data.aws_eks_cluster.cluster.endpoint
  cluster_certificate_authority_data = data.aws_eks_cluster.cluster.certificate_authority[0].data
  depends_on                         = [module.eks]
}
