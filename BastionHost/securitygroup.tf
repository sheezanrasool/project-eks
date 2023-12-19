resource "aws_security_group" "securitygroup" {
  name   = var.security_group_name
  vpc_id = var.vpc_id
  tags   = var.sgtags
  dynamic "ingress" {
    for_each = var.sgingress

    content {
      description     = ingress.value.description
      from_port       = ingress.value.fromport
      to_port         = ingress.value.toport
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidrblocks
      self            = ingress.value.self
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.sgegress

    content {
      description     = egress.value.description
      from_port       = egress.value.fromport
      to_port         = egress.value.toport
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidrblocks
      self            = egress.value.self
      security_groups = egress.value.security_groups
    }
  }
}