# VPC Variables
vpc_cidr                 = "10.0.0.0/16"
vpc_name                 = "Worley-NC-VPC"
internet_gateway_name    = "Worley-NC-IGW"
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
repository_names     = ["worley-nc-ui-k8s", "worley-nc-api-k8s"]
image_tag_mutability = "MUTABLE"
tags = {
  Environment = "dev"
}

# EKS Variables
cluster_name    = "Worley-NC-EKS-Cluster"
node_group_name = "Worley-NC-EKS-Node-Group"
desired_size    = 1
max_size        = 1
min_size        = 1
instance_type   = "t3.medium"
ec2_key_name    = "EKS"
