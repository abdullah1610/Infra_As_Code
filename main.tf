module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}


module "public_subnet" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = var.public_subnet.cidr
  availability_zone = var.public_subnet.az
  subnet_name       = var.public_subnet.name
  map_public_ip     = var.public_subnet.map_public_ip
}


module "private_subnet" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = var.private_subnet.cidr
  availability_zone = var.private_subnet.az
  subnet_name       = var.private_subnet.name
  map_public_ip     = var.private_subnet.map_public_ip
}

module "route" {
  source = "./modules/route-tables"

  vpc_id                   = module.vpc.vpc_id
  public_subnet_id         = module.public_subnet.subnet_id
  private_subnet_id        = module.private_subnet.subnet_id
  public_route_table_name  = var.public_route_table_name
  private_route_table_name = var.private_route_table_name
  nat_name                 = var.nat_name
}


module "security_group" {
  source          = "./modules/security-group"
  vpc_id          = module.vpc.vpc_id
  security_groups = var.security_groups
}

locals {
  resolved_instances = {
    for k, v in var.ec2_instances : k => merge(v, {
      subnet_id          = k == "public_ec2" ? module.public_subnet.subnet_id : module.private_subnet.subnet_id,
      security_group_ids = k == "public_ec2" ? [module.security_group.security_group_ids["public_sg"]] : [module.security_group.security_group_ids["private_sg"]]
    })
  }
}

module "ec2" {
  source    = "./modules/ec2"
  instances = local.resolved_instances
}
