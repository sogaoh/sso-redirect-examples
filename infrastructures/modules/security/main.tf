################################
# Public SG
################################
resource "aws_security_group" "sg_public_module" {
    vpc_id = var.vpc_id
    name        = var.sg_public_name
    description = var.sg_public_description

    tags = {
        Name = var.sg_public_name
    }
}

resource "aws_security_group_rule" "sg_rule_public_80_module" {
    type = "ingress"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = var.sg_public_80_cidr_blocks

    security_group_id = aws_security_group.sg_public_module.id
}

resource "aws_security_group_rule" "sg_rule_public_443_module" {
    type = "ingress"
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = var.sg_public_443_cidr_blocks

    security_group_id = aws_security_group.sg_public_module.id
}

resource "aws_security_group_rule" "sg_rule_public_icmp_module" {
    type = "ingress"
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = var.sg_public_icmp_cidr_blocks

    security_group_id = aws_security_group.sg_public_module.id
}

resource "aws_security_group_rule" "sg_rule_public_out_module" {
    type = "egress"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = var.sg_public_egress_cidr_blocks

    security_group_id = aws_security_group.sg_public_module.id
}


################################
# Private SG
################################
resource "aws_security_group" "sg_private_module" {
    vpc_id = var.vpc_id
    name        = var.sg_private_name
    description = var.sg_private_description

    tags = {
        Name = var.sg_private_name
    }
}

resource "aws_security_group_rule" "sg_rule_private_80_module" {
    type = "ingress"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_group_id = aws_security_group.sg_private_module.id

    source_security_group_id = aws_security_group.sg_public_module.id
}

resource "aws_security_group_rule" "sg_rule_private_9000_module" {
    type = "ingress"
    from_port = 9000
    to_port   = 9000
    protocol  = "tcp"
    cidr_blocks = var.sg_private_9000_cidr_blocks

    security_group_id = aws_security_group.sg_private_module.id
}

resource "aws_security_group_rule" "sg_rule_private_icmp_module" {
    type = "ingress"
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = var.sg_private_icmp_cidr_blocks

    security_group_id = aws_security_group.sg_private_module.id
}

resource "aws_security_group_rule" "sg_rule_private_out_module" {
    type = "egress"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = var.sg_private_egress_cidr_blocks

    security_group_id = aws_security_group.sg_private_module.id
}
