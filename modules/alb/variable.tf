variable "public_alb_name" {
  description = "The name of the public ALB"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be created"
  type        = string
}

variable "public_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet2" {
  description = "The ID of the second public subnet"
  type        = string
}
