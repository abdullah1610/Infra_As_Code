variable "instances" {
  description = "Map of EC2 instance definitions. Each value may include keys: ami, instance_type, subnet_id, security_group_ids, associate_public_ip, key_name, name, tags."
  type    = map(any)
  default = {}
}






