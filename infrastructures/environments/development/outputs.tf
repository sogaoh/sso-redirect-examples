output "out_vpc_id" {
    value = module.dev-network.out_vpc_id
}

output "out_public_subnet_a_id" {
    value = module.dev-network.out_public_subnet_a_id
}

output "out_public_subnet_c_id" {
    value = module.dev-network.out_public_subnet_c_id
}

output "out_private_subnet_b_id" {
    value = module.dev-network.out_private_subnet_b_id
}

output "out_private_subnet_d_id" {
    value = module.dev-network.out_private_subnet_d_id
}

output "out_nat_gw_b_eip" {
    value = module.dev-network.out_nat_gw_b_eip
}

output "out_nat_gw_d_eip" {
    value = module.dev-network.out_nat_gw_d_eip
}

output "out_sg_public_id" {
    value = module.dev-security.out_sg_public_id
}

output "out_sg_private_id" {
    value = module.dev-security.out_sg_private_id
}

output "out_ecs_cluster_name" {
    value = module.dev-ecs-fargate.out_ecs_cluster_name
}

output "out_alb_tg_default_name" {
    value = module.dev-ecs-fargate.out_alb_tg_default_name
}

output "out_alb_dns" {
    value = module.dev-ecs-fargate.out_alb_dns
}
