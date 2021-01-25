module "security" {
    source = "../../modules/security"

    ################################
    # Security Group
    ################################
    vpc_id = module.network.out_vpc_id

    # Public SG
    sg_public_name = "dev-sg-public"
    sg_public_description = "dev public security group"
    sg_public_80_cidr_blocks  = [
        "0.0.0.0/0",
    ]
    sg_public_443_cidr_blocks = [
        "0.0.0.0/0",
    ]
    sg_public_icmp_cidr_blocks = [
        module.network.out_vpc_cidr_block,
    ]
    sg_public_egress_cidr_blocks = [
        "0.0.0.0/0",
    ]

    # Private SG
    sg_private_name = "dev-sg-private"
    sg_private_description = "dev private security group"
    sg_private_icmp_cidr_blocks = [
        module.network.out_vpc_cidr_block,
    ]
    sg_private_9000_cidr_blocks   = [
        module.network.out_vpc_cidr_block,
        "127.0.0.1/32",
    ]
    sg_private_egress_cidr_blocks = [
        "0.0.0.0/0",
    ]
}
