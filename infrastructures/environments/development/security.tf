module "dev-security" {
    source = "../../modules/security"

    ################################
    # Security Group
    ################################
    vpc_id = module.dev-network.out_vpc_id

    # Public SG
    sg_public_name = "dev-sg-public"
    sg_public_description = "dev public security group"
    sg_public_80_cidr_blocks  = [
        "0.0.0.0/0",
    ]
    sg_public_443_cidr_blocks = [
        "0.0.0.0/0",
    ]
    sg_public_egress_cidr_blocks = [
        "0.0.0.0/0",
    ]

    # Private SG
    sg_private_name = "dev-sg-private"
    sg_private_description = "dev private security group"
    sg_private_icmp_cidr_blocks = [
        module.dev-network.out_vpc_cidr_block,
    ]
    sg_private_22_cidr_blocks   = [
        module.dev-network.out_vpc_cidr_block,
    ]

}
