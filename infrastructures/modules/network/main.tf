################################
# VPC
################################
resource "aws_vpc" "vpc_module" {
    cidr_block           = var.vpc_cidr_block
    instance_tenancy     = "default"
    enable_dns_hostnames = false
    enable_dns_support   = true

    tags = {
        Name = var.vpc_name
    }
}


################################
# Subnet
################################
resource "aws_subnet" "public_subnet_a_module" {
    vpc_id = aws_vpc.vpc_module.id
    availability_zone = "ap-northeast-1a"

    cidr_block                      = var.subnet_a_cidr_block
    map_public_ip_on_launch         = true
    assign_ipv6_address_on_creation = false

    tags = {
        Name = var.subnet_a_name
    }
}

resource "aws_subnet" "public_subnet_c_module" {
    vpc_id = aws_vpc.vpc_module.id
    availability_zone = "ap-northeast-1c"

    cidr_block                      = var.subnet_c_cidr_block
    map_public_ip_on_launch         = true
    assign_ipv6_address_on_creation = false

    tags = {
        Name = var.subnet_c_name
    }
}


################################
# Internet Gateway
################################
resource "aws_internet_gateway" "igw_module" {
    vpc_id = aws_vpc.vpc_module.id

    tags = {
        Name = var.igw_name
    }
}


################################
# Route Table
################################
resource "aws_route_table" "rt_module" {
    vpc_id = aws_vpc.vpc_module.id
    route {
        cidr_block = var.rt_cidr_block
        gateway_id = aws_internet_gateway.igw_module.id
    }

    tags = {
        Name = var.rt_name
    }
}

resource "aws_route_table_association" "rt_assoc_a_module" {
    route_table_id = aws_route_table.rt_module.id
    subnet_id      = aws_subnet.public_subnet_a_module.id
}

resource "aws_route_table_association" "rt_assoc_c_module" {
    route_table_id = aws_route_table.rt_module.id
    subnet_id      = aws_subnet.public_subnet_c_module.id
}
