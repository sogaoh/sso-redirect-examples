module "dev-ecs-fargate" {
    source = "../../modules/ecs-fargate"

    environment_name = "dev"
    product_name = "sso-examples"       //=TF_VAR_PRODUCT_NAME

    ################################
    # IAM
    ################################

    ################################
    # CloudWatch Log Group
    ################################
    ecs_service_name = "auth-client"    //=TF_VAR_ECS_SERVICE_NAME

    ################################
    # ECS Cluster
    ################################

    ################################
    # ALB
    ################################
    vpc_id = module.dev-network.out_vpc_id
    public_subnet_a_id = module.dev-network.out_public_subnet_a_id
    public_subnet_c_id = module.dev-network.out_public_subnet_c_id
    sg_public_id = module.dev-security.out_sg_public_id
}