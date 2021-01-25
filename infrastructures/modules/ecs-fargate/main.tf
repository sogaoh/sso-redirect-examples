################################
# IAM
################################
data "aws_iam_policy_document" "ecs_tasks_exec_iam_policy_module" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}
resource "aws_iam_role" "ecs_tasks_exec_iam_role_module" {
    name = "${var.environment_name}-${var.product_name}-ecs-task-execution-role"
    assume_role_policy = data.aws_iam_policy_document.ecs_tasks_exec_iam_policy_module.json

    tags = {
        Name = "${var.environment_name}-${var.product_name}-ecs-task-execution-role"
    }
}
resource "aws_iam_role_policy_attachment" "ecs_tasks_exec_iam_policy_attachment_module" {
    role = aws_iam_role.ecs_tasks_exec_iam_role_module.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


################################
# CloudWatch Log Group
################################
resource "aws_cloudwatch_log_group" "ecs_cloudwatch_logs_module" {
    name = "/ecs/${var.environment_name}-${var.product_name}/${var.ecs_service_name}"

    tags = {
        Name = "/ecs/${var.environment_name}-${var.product_name}/${var.ecs_service_name}"
    }
}


################################
# ECS Cluster
################################
resource "aws_ecs_cluster" "ecs_cluster_module" {
    name = "${var.environment_name}-${var.product_name}-ecs-cluster"

    setting {
        name  = "containerInsights"
        value = "disabled"
    }

    tags = {
        Name = var.ecs_cluster_name
    }
}


################################
# ALB
################################
resource "aws_lb" "alb_module" {
    load_balancer_type = "application"
    name = var.alb_name

    security_groups = [var.sg_public_id]
    subnets = [var.public_subnet_a_id, var.public_subnet_c_id]

    tags = {
        Name = var.alb_name
    }
}

resource "aws_lb_listener" "alb_80_listener_module" {
    load_balancer_arn = aws_lb.alb_module.id

    default_action {
        target_group_arn = aws_lb_target_group.alb_target_group_default_module.arn
        type = "forward"
    }

    port = 80
    protocol = "HTTP"
}

resource "aws_lb_listener" "alb_443_listener_module" {
    load_balancer_arn = aws_lb.alb_module.id

    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.certificate_arn

    default_action {
        target_group_arn = aws_lb_target_group.alb_target_group_default_module.arn
        type = "forward"
    }

    port = 443
    protocol = "HTTPS"
}


resource "aws_lb_target_group" "alb_target_group_default_module" {
    name = var.alb_default_target_name

    vpc_id = var.vpc_id

    target_type = "ip"

    port = 80
    protocol = "HTTP"

    tags = {
        Name = var.alb_default_target_name
    }
}


resource "aws_route53_record" "route53_CNAME_module" {
    zone_id = var.zone_id
    name    = var.dns_sub_domain
    ttl     = var.dns_cname_ttl
    type    = "CNAME"
    records = [
        aws_lb.alb_module.dns_name,
    ]
}
