variable "public_alb_name" {
  type = string
}
variable "private_alb_name" {
  type = string
}

variable "vpc_id" {
  type        = string
}

variable "public_subnet1" {
  type = string
}

variable "public_subnet2" {
    type = string
}

variable "private_subnet1" {
  type = string
}

variable "private_subnet2" {
    type = string
}

variable "public_eks_cidr" {
    type = string
}

variable "private_eks_cidr" {
    type = string
}

variable "api_gateway_cidr" {
    type = string
  
}

variable "public_eks_name" {
  type = string
}

variable "private_eks_name" {
   type = string
}

variable "private_subnets" {
  type = string
}

variable "public_subnets" {
  type = string
}