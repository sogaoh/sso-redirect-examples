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

output "out_igw_id" {
    value = aws_internet_gateway.igw_module.id
}

output "out_rt_id" {
    value = aws_route_table.rt_module.id
}
