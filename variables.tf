# ---------- AWS ----------
variable "aws_region" {
  description = "AWS region"
  type        = string
}

# ---------- VPC ----------
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

# ---------- PUBLIC SUBNET ----------
variable "public_subnet" {
  description = "Public subnet configuration"
  type = object({
    cidr          = string
    az            = string
    name          = string
    map_public_ip = bool
  })
}

# ---------- PRIVATE SUBNET ----------
variable "private_subnet" {
  description = "Private subnet configuration"
  type = object({
    cidr          = string
    az            = string
    name          = string
    map_public_ip = bool
  })
}


# ---------- ROUTE ----------
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


variable "ec2_instances" {
  description = "EC2 instances configuration"
  type = map(object({
    ami                 = string
    instance_type       = string
    subnet_id           = string
    security_group_ids  = list(string)
    associate_public_ip = bool
    key_name            = string
    name                = string
  }))
}


variable "security_groups" {
  description = "Security groups configuration"
  type = map(object({
    name        = string
    description = string

    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))

    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
