variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "map_public_ip" {
  description = "Auto assign public IP"
  type        = bool
}