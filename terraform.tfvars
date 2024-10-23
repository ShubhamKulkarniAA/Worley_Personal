vpc_cidr = "10.0.0.0/16"
vpc_name = "Worley-NC"
internet_gateway_name = "Worley-NC-IG"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.2.0/24"
private_subnet1_cidr = "10.0.3.0/24"
private_subnet2_cidr = "10.0.4.0/24"
private_rds_subnet1_cidr = "10.0.5.0/24"
private_rds_subnet2_cidr = "10.0.6.0/24"
availability_zone1 = "ap-south-1a"
availability_zone2 = "ap-south-1b"
region = "ap-south-1"

# ALB Veriables
public_alb_name = "worley-nc-public-alb"
private_alb_name = "worley-nc-private-alb"
/*certificate_arn = ""*/
private_eks_cidr = "10.0.7.0/24"
public_eks_cidr = "10.0.8.0/24"
api_gateway_cidr = "10.0.9.0/24"
private_nlb_name = "worley-nc-private-nlb"

# New variables for EKS

cluster_name = "Worley-NC-EKS"
node_group_name = "Worley-NC-EKS-NG"


# New variable for ECR

ecr_repository_name = "demo-worley-nc-ui"
