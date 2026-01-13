variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}


variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "public_route_table_name" {
  description = "Public Route table name"
  type        = string
}

variable "private_route_table_name" {
  description = "Private Route table name"
  type        = string
}


variable "nat_name" {
  description = "NAT Gateway name"
  type        = string
}