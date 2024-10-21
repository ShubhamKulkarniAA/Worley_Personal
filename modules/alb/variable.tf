# Variables
variable "public_alb_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet1" {
  type = string
}

variable "public_subnet2" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate in AWS Certificate Manager"
  type        = string
}