output "vpc_id" {
  value = aws_vpc.vpc.id 
}

output "vpc_arn" {
  value = aws_vpc.vpc.arn 
}

output "rds_private_subnet1_id" {
  value = aws_subnet.rds_private_subnet1.id
}

output "rds_private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "s3_vpc_endpoint_id" {
  value       = aws_vpc_endpoint.s3-vpc-endpoint.id
}

output "s3_vpc_endpoint_dns" {
  value       = aws_vpc_endpoint.s3-vpc-endpoint.dns_entry[0].dns_name
}

output "s3_vpc_endpoint_arn" {
  value       = aws_vpc_endpoint.s3-vpc-endpoint.arn
}
