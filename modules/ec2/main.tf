resource "aws_instance" "this" {
  for_each = var.instances
  ami           = lookup(each.value, "ami", null)
  instance_type = lookup(each.value, "instance_type", null)
  subnet_id     = lookup(each.value, "subnet_id", null)

  vpc_security_group_ids      = lookup(each.value, "security_group_ids", [])
  associate_public_ip_address = lookup(each.value, "associate_public_ip", false)
  key_name                    = lookup(each.value, "key_name", null)

  tags = merge(lookup(each.value, "tags", {}), {
    Name = lookup(each.value, "name", each.key)
  })
}
