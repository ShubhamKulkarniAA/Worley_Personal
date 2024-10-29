# VPC Variables
variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "availability_zone1" {
  type = string
}

variable "public_subnet2_cidr" {
  type = string
}

variable "availability_zone2" {
  type = string
}

variable "private_subnet1_cidr" {
  type = string
}

variable "private_subnet2_cidr" {
  type = string
}

variable "private_rds_subnet1_cidr" {
  type = string
}

variable "private_rds_subnet2_cidr" {
  type = string
}

variable "region" {
  type = string
}


# ALB Variables
variable "public_alb_name" {
  type = string
}


# ECR Variables
variable "repository_name" {
  type = string
}

variable "image_tag_mutability" {
  type = string
  default = "MUTABLE"
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "lifecycle_policy" {
  type = map(any)
  default = {
    rules = [
      {
        rulePriority = 1
        selectionCriteria = {
          tagStatus = "TAGGED"
          tagPrefixList = ["latest"]
        }
        action = {
          type = "expire"
        }
        expiry = {
          days = 30
        }
      }
    ]
  }
}


# EKS Variables
variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}
