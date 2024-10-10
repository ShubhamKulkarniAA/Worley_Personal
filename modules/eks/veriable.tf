variable "public_alb_name" {
  type = string
}
variable "private_alb_name" {
  type = string
}

variable "vpc_id" {
  type        = string
}

variable "certificate_arn" {
  type = string
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