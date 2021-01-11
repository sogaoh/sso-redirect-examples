module "dev-network" {
    source = "../../modules/network"

    ################################
    # VPC
    ################################
    vpc_name       = "dev-vpc"
    vpc_cidr_block = "10.0.0.0/16"

    ################################
    # Subnet
    ################################
    subnet_a_name = "dev-subnet-a"
    subnet_a_cidr_block = "10.0.0.0/24"

    subnet_c_name = "dev-subnet-c"
    subnet_c_cidr_block = "10.0.1.0/24"


    ################################
    # Internet Gateway
    ################################
    igw_name = "dev-igw"

    ################################
    # Route Table
    ################################
    rt_name = "dev-rt"
    rt_cidr_block = "0.0.0.0/0"
}
