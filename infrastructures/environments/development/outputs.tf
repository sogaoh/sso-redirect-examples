output "out_vpc_id" {
    value = module.dev-network.out_vpc_id
}

output "out_public_subnet_a_id" {
    value = module.dev-network.out_public_subnet_a_id
}

output "out_public_subnet_c_id" {
    value = module.dev-network.out_public_subnet_c_id
}

output "out_sg_public_id" {
    value = module.dev-security.out_sg_public_id
}

output "out_sg_private_id" {
    value = module.dev-security.out_sg_private_id
}
