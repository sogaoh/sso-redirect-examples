output "out_ecs_cluster_name" {
    value = aws_ecs_cluster.ecs_cluster_module.name
}

output "out_alb_dns" {
    value = aws_lb.alb_module.dns_name
}

output "out_alb_tg_default_name" {
    value = aws_lb_target_group.alb_target_group_default_module.name
}
