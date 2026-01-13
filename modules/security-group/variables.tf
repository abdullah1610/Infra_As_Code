variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_groups" {
  description = "Map of security group definitions. Each value can include keys: name, description, ingress (list), egress (list), tags (map)."
  type        = map(any)
  default     = {}
}
