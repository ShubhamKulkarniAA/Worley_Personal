module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
  private_rds_subnet1_cidr = var.private_rds_subnet1_cidr
  private_rds_subnet2_cidr = var.private_rds_subnet2_cidr
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
}

module "alb" {
  source = "./modules/alb"
  public_alb_name = var.public_alb_name
  private_alb_name = var.private_alb_name
  vpc_id  = module.vpc.vpc_id  
  public_subnet1  = module.vpc.public_subnet1_id
  public_subnet2 = module.vpc.public_subnet2_id
  private_subnet1 = module.vpc.private_subnet1_id
  private_subnet2 = module.vpc.private_subnet2_id
  certificate_arn = var.certificate_arn
  private_eks_cidr = var.private_eks_cidr
  public_eks_cidr = var.public_eks_cidr
  api_gateway_cidr = var.api_gateway_cidr
}

#EKS

/*module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  subnet_ids = [
    module.vpc.public_subnet1_id,
    module.vpc.public_subnet2_id,
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
  node_group_name = "${var.cluster_name}-node-group"

}*/
