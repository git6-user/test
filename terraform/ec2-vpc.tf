module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.5"
  #count = min(var.public_instances_per_vpc, local.max_public_instances)
  
  for_each = local.subnet_map

  name = "instance-${each.key}"

  instance_type = var.map[var.environment]
  key_name      = "eks_keypair"
  subnet_id     = each.value.subnet_id
  associate_public_ip_address = each.value.type == "public"
  create_eip = each.value.type == "public" ? true : false

  vpc_security_group_ids = each.value.type == "public" ? [
    aws_security_group.vpc-web-sg-pub[each.value.vpc_index].id
  ] : [
    aws_security_group.vpc-sg-pri[each.value.vpc_index].id
  ]

  tags = {
    Name = "${each.value.type}-ec2-vpc-${each.value.vpc_index}-${each.key}"
    Type = each.value.type
}
}

