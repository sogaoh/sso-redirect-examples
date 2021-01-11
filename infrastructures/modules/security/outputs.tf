output "sg_public_id" {
    value = aws_security_group.sg_public_module.id
}

output "sg_private_id" {
    value = aws_security_group.sg_private_module.id
}
