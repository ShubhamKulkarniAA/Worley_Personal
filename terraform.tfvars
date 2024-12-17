# VPC Variables
vpc_cidr                 = "10.0.0.0/16"
vpc_name                 = "Demo-VPC"
internet_gateway_name    = "Demo-IGW"
public_subnet1_cidr      = "10.0.1.0/24"
public_subnet2_cidr      = "10.0.2.0/24"
private_subnet1_cidr     = "10.0.3.0/24"
private_subnet2_cidr     = "10.0.4.0/24"
private_rds_subnet1_cidr = "10.0.5.0/24"
private_rds_subnet2_cidr = "10.0.6.0/24"
availability_zone1       = "ap-south-1a"
availability_zone2       = "ap-south-1b"
region                   = "ap-south-1"

#ECR Variables
repository_names     = ["demo-ui-k8s", "demo-api-k8s"]
image_tag_mutability = "MUTABLE"
tags = {
  Environment = "development"
}

# EKS Variables
cluster_name    = "EKS-Cluster"
node_group_name = "EKS-Node-Group"
desired_size    = 1
max_size        = 1
min_size        = 1
instance_type   = "t3.medium"
ec2_key_name    = "EKS"
