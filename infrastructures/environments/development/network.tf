module "network" {
    source = "../../modules/network"

    ################################
    # VPC
    ################################
    vpc_name       = "dev-vpc"
    vpc_cidr_block = "10.0.0.0/16"

    ################################
    # Subnet
    ################################
    subnet_a_name = "dev-public-subnet-a"
    subnet_a_cidr_block = "10.0.0.0/24"

    subnet_c_name = "dev-public-subnet-c"
    subnet_c_cidr_block = "10.0.1.0/24"

    subnet_b_name = "dev-private-subnet-b"
    subnet_b_cidr_block = "10.0.100.0/24"

    subnet_d_name = "dev-private-subnet-d"
    subnet_d_cidr_block = "10.0.101.0/24"


    ################################
    # Internet Gateway
    ################################
    igw_name = "dev-igw"

    ################################
    # NAT Gateway
    ################################
    nat_gw_a_name = "dev-nat-gw-b"
    nat_gw_c_name = "dev-nat-gw-d"

    ################################
    # Route Table
    ################################
    public_rt_name = "dev-public-rt"
    public_rt_cidr_block = "0.0.0.0/0"

    private_rt_b_name = "dev-private-b-rt"
    private_rt_b_cidr_block = "0.0.0.0/0"

    private_rt_d_name = "dev-private-d-rt"
    private_rt_d_cidr_block = "0.0.0.0/0"
}
