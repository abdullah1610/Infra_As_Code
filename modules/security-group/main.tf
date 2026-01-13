resource "aws_security_group" "this" {
  for_each = var.security_groups
  name        = lookup(each.value, "name", each.key)
  description = lookup(each.value, "description", "Managed by Terraform")
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = lookup(each.value, "ingress", [])
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = lookup(each.value, "egress", [])
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      description = lookup(egress.value, "description", null)
    }
  }

  tags = merge(lookup(each.value, "tags", {}), {
    Name = lookup(each.value, "name", each.key)
  })
}
