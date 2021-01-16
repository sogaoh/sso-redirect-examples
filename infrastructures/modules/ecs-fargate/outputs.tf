output "out_ecs_cluster_id" {
    value = aws_ecs_cluster.ecs_cluster_module.id
}

output "out_alb_dns" {
    value = aws_lb.alb_module.dns_name
}

output "out_alb_80_tg_name" {
    value = aws_lb_target_group.alb_80_target_group_module.name
}
