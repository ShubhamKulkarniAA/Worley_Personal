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
  vpc_id = var.vpc_id
  public_subnet1 = var.public_subnet1
  public_subnet2 = var.public_subnet2
  private_subnet1 = var.private_subnet1
  private_subnet2 = var.private_subnet2
  public_eks_cidr = var.public_eks_cidr
  private_eks_cidr = var.private_eks_cidr
  api_gateway_cidr = var.api_gateway_cidr
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  public_eks_name = var.public_eks_name
  private_eks_name = var.private_eks_name
 
} 

 /* public_eks_cidr = 
  private_eks_cidr = */