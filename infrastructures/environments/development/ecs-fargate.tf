module "ecs-fargate" {
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
    ecs_cluster_name = "dev-sso-examples"

    ################################
    # ALB
    ################################
    zone_id =  var.dns_zone_id
    certificate_arn = var.wc_certificate_arn
    dns_sub_domain = "dev-sso-examples"
    dns_cname_ttl = 30

    alb_name = "dev-sso-examples-alb"
    alb_default_target_name = "dev-sso-examples-ecs"

    vpc_id = module.network.out_vpc_id
    public_subnet_a_id = module.network.out_public_subnet_a_id
    public_subnet_c_id = module.network.out_public_subnet_c_id
    sg_public_id = module.security.out_sg_public_id
}
