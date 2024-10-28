vpc_cidr                  = "10.0.0.0/16"
vpc_name                  = "Worley-NC"
internet_gateway_name      = "Worley-NC-IG"
public_subnet1_cidr      = "10.0.1.0/24"
public_subnet2_cidr      = "10.0.2.0/24"
availability_zone1       = "us-east-2a"
availability_zone2       = "us-east-2b"
region                    = "us-east-2"

# ALB Variables
public_alb_name          = "worley-nc-public-alb"
# certificate_arn = ""  # Uncomment and set if using SSL certificates
public_eks_cidr          = "10.0.8.0/24"
api_gateway_cidr         = "10.0.9.0/24"

# EKS & ECR
cluster_name = "Worley-NC-EKS"
node_group_name = "Worley-NC-EKS-NG"
