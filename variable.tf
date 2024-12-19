# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "internet_gateway_name" {
  description = "Name of the internet gateway"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_rds_subnet1_cidr" {
  description = "CIDR block for the first private RDS subnet"
  type        = string
}

variable "private_rds_subnet2_cidr" {
  description = "CIDR block for the second private RDS subnet"
  type        = string
}

variable "availability_zone1" {
  description = "Availability zone 1"
  type        = string
}

variable "availability_zone2" {
  description = "Availability zone 2"
  type        = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
}

# # EKS Variables
# variable "cluster_name" {
#   type = string
# }

# variable "node_group_name" {
#   type = string
# }

# variable "desired_size" {
#   type = number
# }

# variable "max_size" {
#   type = number
# }

# variable "min_size" {
#   type = number
# }

# variable "instance_type" {
#   description = "The EC2 instance type for EKS worker nodes"
#   type        = string
# }

# variable "ec2_key_name" {
#   description = "The name of the EC2 key pair used for SSH access"
#   type        = string
# }
