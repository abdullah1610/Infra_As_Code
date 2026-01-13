# Root outputs referencing modules declared in main.tf

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id
}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id
}

output "igw_id" {
  value = module.route.igw_id
}

output "nat_gateway_id" {
  value = module.route.nat_gateway_id
}

output "public_route_table_id" {
  value = module.route.public_route_table_id
}

output "private_route_table_id" {
  value = module.route.private_route_table_id
}

output "security_group_ids" {
  value = module.security_group.security_group_ids
}

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "private_ips" {
  value = module.ec2.private_ips
}

output "public_ips" {
  value = module.ec2.public_ips
}
