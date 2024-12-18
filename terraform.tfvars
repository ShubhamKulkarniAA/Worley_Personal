# VPC Variables
vpc_cidr                 = "10.0.0.0/16"
vpc_name                 = "EKS-VPC"
internet_gateway_name    = "EKS-IGW"
public_subnet1_cidr      = "10.0.1.0/24"
public_subnet2_cidr      = "10.0.2.0/24"
private_subnet1_cidr     = "10.0.3.0/24"
private_subnet2_cidr     = "10.0.4.0/24"
private_rds_subnet1_cidr = "10.0.5.0/24"
private_rds_subnet2_cidr = "10.0.6.0/24"
availability_zone1       = "ap-south-1a"
availability_zone2       = "ap-south-1b"
region                   = "ap-south-1"

# EKS Variables
cluster_name    = "my-eks-cluster"
cluster_version = "1.31"
