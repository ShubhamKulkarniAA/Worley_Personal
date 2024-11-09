# VPC Variables
vpc_cidr = "10.0.0.0/16"
vpc_name = "Worley-NC"
internet_gateway_name = "Worley-NC-IG"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.2.0/24"
private_subnet1_cidr = "10.0.3.0/24"
private_subnet2_cidr = "10.0.4.0/24"
private_rds_subnet1_cidr = "10.0.5.0/24"
private_rds_subnet2_cidr = "10.0.6.0/24"
availability_zone1 = "ap-southeast-1a"
availability_zone2 = "ap-southeast-1b"
region = "ap-southeast-1"

# ALB Variables
public_alb_name = "Worley-NC-Public-ALB"

# ECR Variables
repository_name = "worley-nc-ecr-repo"
image_tag_mutability = "MUTABLE"
tags = {
  Environment = "dev"
}

# EKS Variables
cluster_name     = "Worley-NC-EKS-Cluster"
node_group_name  = "EKS-Node-Group"
desired_size     = 1
max_size         = 1
min_size         = 1
instance_type    = "t3.medium"
ec2_key_name     = "EKS"
ami_id           = "ami-07548161ae91256a2"
