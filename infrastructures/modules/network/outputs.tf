output "out_vpc_id" {
    value = aws_vpc.vpc_module.id
}
output "out_vpc_cidr_block" {
    value = aws_vpc.vpc_module.cidr_block
}

output "out_public_subnet_a_id" {
    value = aws_subnet.public_subnet_a_module.id
}
output "out_public_subnet_a_cidr_block" {
    value = aws_subnet.public_subnet_a_module.cidr_block
}

output "out_public_subnet_c_id" {
    value = aws_subnet.public_subnet_c_module.id
}
output "out_public_subnet_c_cidr_block" {
    value = aws_subnet.public_subnet_c_module.cidr_block
}

output "out_private_subnet_b_id" {
    value = aws_subnet.private_subnet_b_module.id
}
output "out_private_subnet_b_cidr_block" {
    value = aws_subnet.private_subnet_b_module.cidr_block
}

//output "out_private_subnet_d_id" {
//    value = aws_subnet.private_subnet_d_module.id
//}
//output "out_private_subnet_d_cidr_block" {
//    value = aws_subnet.private_subnet_d_module.cidr_block
//}

output "out_igw_id" {
    value = aws_internet_gateway.igw_module.id
}

output "out_nat_gw_b_eip" {
    value = aws_nat_gateway.nat_gw_b_module.public_ip
}
//output "out_nat_gw_d_eip" {
//    value = aws_nat_gateway.nat_gw_d_module.public_ip
//}

output "out_public_rt_id" {
    value = aws_route_table.public_rt_module.id
}

output "out_private_rt_b_id" {
    value = aws_route_table.private_rt_b_module.id
}

//output "out_private_rt_d_id" {
//    value = aws_route_table.private_rt_d_module.id
//}
