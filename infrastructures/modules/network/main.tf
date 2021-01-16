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

resource "aws_subnet" "private_subnet_b_module" {
    vpc_id = aws_vpc.vpc_module.id
    availability_zone = "ap-northeast-1c"   //"ap-northeast-1b" is unavailable

    cidr_block                      = var.subnet_b_cidr_block
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false

    tags = {
        Name = var.subnet_b_name
    }
}

resource "aws_subnet" "private_subnet_d_module" {
    vpc_id = aws_vpc.vpc_module.id
    availability_zone = "ap-northeast-1d"

    cidr_block                      = var.subnet_d_cidr_block
    map_public_ip_on_launch         = false
    assign_ipv6_address_on_creation = false

    tags = {
        Name = var.subnet_d_name
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
# NAT Gateway
################################
resource "aws_nat_gateway" "nat_gw_b_module" {
    allocation_id = aws_eip.nat_gw_eip_b_module.id
    subnet_id     = aws_subnet.public_subnet_a_module.id
    depends_on    = [aws_internet_gateway.igw_module]
}
resource "aws_eip" "nat_gw_eip_b_module" {
    vpc        = true
    depends_on = [aws_internet_gateway.igw_module]
}

resource "aws_nat_gateway" "nat_gw_d_module" {
    allocation_id = aws_eip.nat_gw_eip_d_module.id
    subnet_id     = aws_subnet.public_subnet_c_module.id
    depends_on    = [aws_internet_gateway.igw_module]
}
resource "aws_eip" "nat_gw_eip_d_module" {
    vpc        = true
    depends_on = [aws_internet_gateway.igw_module]
}

################################
# Route Table
################################
resource "aws_route_table" "public_rt_module" {
    vpc_id = aws_vpc.vpc_module.id
    route {
        cidr_block = var.public_rt_cidr_block
        gateway_id = aws_internet_gateway.igw_module.id
    }

    tags = {
        Name = var.public_rt_name
    }
}

resource "aws_route_table_association" "rt_assoc_a_module" {
    route_table_id = aws_route_table.public_rt_module.id
    subnet_id      = aws_subnet.public_subnet_a_module.id
}

resource "aws_route_table_association" "rt_assoc_c_module" {
    route_table_id = aws_route_table.public_rt_module.id
    subnet_id      = aws_subnet.public_subnet_c_module.id
}


resource "aws_route_table" "private_rt_b_module" {
    vpc_id = aws_vpc.vpc_module.id

    route {
        cidr_block = var.private_rt_b_cidr_block
        nat_gateway_id = aws_nat_gateway.nat_gw_b_module.id
    }

    tags = {
        Name = var.private_rt_b_name
    }
}

resource "aws_route_table_association" "private_rt_assoc_b_module" {
    subnet_id = aws_subnet.private_subnet_b_module.id
    route_table_id = aws_route_table.private_rt_b_module.id
}


resource "aws_route_table" "private_rt_d_module" {
    vpc_id = aws_vpc.vpc_module.id

    route {
        cidr_block = var.private_rt_d_cidr_block
        nat_gateway_id = aws_nat_gateway.nat_gw_d_module.id
    }

    tags = {
        Name = var.private_rt_d_name
    }
}

resource "aws_route_table_association" "private_rt_assoc_d_module" {
    subnet_id = aws_subnet.private_subnet_d_module.id
    route_table_id = aws_route_table.private_rt_d_module.id
}
