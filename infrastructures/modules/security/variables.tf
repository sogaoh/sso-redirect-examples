variable "sg_public_name" {}
variable "sg_public_description" {}

variable "sg_public_80_cidr_blocks" {}
variable "sg_public_443_cidr_blocks" {}
variable "sg_public_icmp_cidr_blocks" {}
variable "sg_public_egress_cidr_blocks" {}

variable "sg_private_name" {}
variable "sg_private_description" {}

//variable "sg_private_80_cidr_blocks" {}
variable "sg_private_9000_cidr_blocks" {}
variable "sg_private_icmp_cidr_blocks" {}
variable "sg_private_egress_cidr_blocks" {}


variable "vpc_id" {}
