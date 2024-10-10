output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "rds_private_subnet1_id" {
 value = module.vpc.rds_private_subnet1_id 
}

output "rds_private_subnet2_id" {
 value = module.vpc.rds_private_subnet2_id 
}

output "bucket_name_vpc" {
  value = module.s3.bucket_name_vpc
}

output "bucket_name_vpc_arn" {
  value = module.s3.bucket_name_vpc_arn
}

output "public_subnet1_id" {
  value = module.vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.vpc.public_subnet2_id
}

output "private_subnet1_id" {
  value = module.vpc.private_subnet1_id
}

output "private_subnet2_id" {
  value = module.vpc.private_subnet2_id
}

/*output "public_alb_arn" {
  value = module.alb.public_alb_arn
}

output "Public_alb_tg_arn" {
  value = module.alb.public_alb_tg_arn
}

output "private_alb_arn" {
  value = module.alb.private_alb_arn
}

output "Private_alb_tg_arn" {
  value = module.alb.private_alb_tg_arn
}*/

