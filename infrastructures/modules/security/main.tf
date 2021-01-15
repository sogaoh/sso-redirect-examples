resource "aws_security_group" "sg_public_module" {
    vpc_id = var.vpc_id

    name        = var.sg_public_name
    description = var.sg_public_description

    ingress {
        from_port    = 80
        to_port      = 80
        protocol     = "tcp"
        cidr_blocks  = var.sg_public_80_cidr_blocks
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.sg_public_443_cidr_blocks
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.sg_public_egress_cidr_blocks
    }

    tags = {
        Name = var.sg_public_name
    }
}


resource "aws_security_group" "sg_private_module" {
    vpc_id = var.vpc_id

    name        = var.sg_private_name
    description = var.sg_private_description

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.sg_private_22_cidr_blocks
    }

    ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = var.sg_private_icmp_cidr_blocks
    }

    tags = {
        Name = var.sg_private_name
    }
}
