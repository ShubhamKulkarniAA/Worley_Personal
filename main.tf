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

module "ecr" {
  source               = "./modules/ecr"
  repository_names     = var.repository_names
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  desired_size    = var.desired_size
  max_size        = var.max_size
  min_size        = var.min_size
  ec2_key_name    = var.ec2_key_name
  instance_type   = var.instance_type
  subnet_ids      = [module.vpc.public_subnet1_id, module.vpc.public_subnet2_id]
  depends_on      = [module.vpc]
}

module "lbc" {
  source            = "./modules/lbc"
  region            = var.region
  cluster_name      = module.eks.cluster_name
  vpc_id            = module.vpc.vpc_id
  oidc_provider_url = module.eks.oidc_provider_url
  oidc_provider_arn = module.eks.oidc_provider_arn
}

resource "aws_iam_role_policy_attachment" "lbc_node_policy" {
  policy_arn = module.lbc.lbc_custom_policy_arn
  role       = module.eks.eks_node_role
}
