output "out_sg_public_id" {
    value = aws_security_group.sg_public_module.id
}

output "out_sg_private_id" {
    value = aws_security_group.sg_private_module.id
}
