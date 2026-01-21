# ---------- AWS ----------
aws_region = "us-east-1"

# ---------- VPC ----------
vpc_cidr = "10.0.0.0/12"
vpc_name = "dev-vpc-prod"


# ---------- PUBLIC SUBNET ----------
public_subnet = {
  cidr          = "10.0.1.0/24"
  az            = "us-east-1a"
  name          = "public-subnet-1"
  map_public_ip = true
}

# ---------- PRIVATE SUBNET ----------
private_subnet = {
  cidr          = "10.0.2.0/24"
  az            = "us-east-1a"
  name          = "private-subnet-1"
  map_public_ip = false
}

# ---------- ROUTE ----------
public_route_table_name  = "dev-public-rt"
private_route_table_name = "dev-private-rt"
nat_name                 = "dev-nat-gateway"

# ---------- Public instance  ----------
ec2_instances = {
  public_ec2 = {
    ami                 = "ami-0c02fb55956c7d316"
    instance_type       = "t2.micro"
    subnet_id           = "<PUBLIC_SUBNET_ID>"
    security_group_ids  = ["<PUBLIC_SG_ID>"]
    associate_public_ip = true
    key_name            = null                    #key_name            = "dev-key"
    name                = "dev-public-ec2"
  }

  # ---------- Private instance  ----------
  private_ec2 = {
    ami                 = "ami-0c02fb55956c7d316"
    instance_type       = "t2.micro"
    subnet_id           = "<PRIVATE_SUBNET_ID>"
    security_group_ids  = ["<PRIVATE_SG_ID>"]
    associate_public_ip = false
    key_name            = null                    #key_name            = "dev-key"
    name                = "dev-private-ec2"
  }
}


# ---------- Security groups  ----------
security_groups = {
  public_sg = {
    name        = "dev-public-sg"
    description = "Public SG for EC2"

    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]

    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  private_sg = {
    name        = "dev-private-sg"
    description = "Private SG for backend"

    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]

    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}
