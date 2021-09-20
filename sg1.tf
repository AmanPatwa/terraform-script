resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.allow_tls1.id
}

resource "aws_security_group_rule" "ingress_rules1" {
  count = length(var.ingress_rules_1)

  type              = "ingress"
  from_port         = var.ingress_rules_1[count.index].from_port
  to_port           = var.ingress_rules_1[count.index].to_port
  protocol          = var.ingress_rules_1[count.index].protocol
  cidr_blocks       = [var.ingress_rules_1[count.index].cidr_block]
  description       = var.ingress_rules_1[count.index].description
  security_group_id = aws_security_group.allow_tls.id
}

resource "aws_security_group_rule" "egress_rules" {
  count = length(var.egress_rules)

  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_block]
  description       = var.egress_rules[count.index].description
  security_group_id = aws_security_group.allow_tls.id
}

resource "aws_security_group_rule" "egress_rules1" {
  count = length(var.egress_rules)

  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_block]
  description       = var.egress_rules[count.index].description
  security_group_id = aws_security_group.allow_tls1.id
}
