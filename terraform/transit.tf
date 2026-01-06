# module "tgw" {
#   depends_on = [ module.vpc ]

#   count = var.run_required_resourse_module ? length(var.vpc_cidrs) : 0
#   source = "terraform-aws-modules/transit-gateway/aws"

#   name            = "vpc-${count.index}"
#   description     = "My TGW shared with several other AWS accounts"
#   amazon_side_asn = 64599

#   transit_gateway_cidr_blocks = ["12.99.0.0/24"]

#   # When "true" there is no need for RAM resources if using multiple AWS accounts
#   enable_auto_accept_shared_attachments = false

#   # When "true", SG referencing support is enabled at the Transit Gateway level
#   enable_sg_referencing_support = false

#   # When "true", allows service discovery through IGMP
#   enable_multicast_support = false
#   # Whether to share your transit gateway with other
#   share_tgw = false

#   vpc_attachments = {
#     vpc = {
#       vpc_id                             = module.vpc[count.index].vpc_id
#       subnet_ids                         = module.vpc[count.index].private_subnets
#       security_group_referencing_support = true
#       dns_support                        = false
#       ipv6_support                       = false

#       transit_gateway_default_route_table_association = true
#       transit_gateway_default_route_table_propagation = true
#     tgw_vpc_attachment_tags = {
#       Name = "tgw-attachment-to-vpc-${count.index}"
#     }
#   tags = {
#     Terraform   = "true"
#     Environment = var.environment
#   }
# }
# }
# }

module "tgw" {
  source = "terraform-aws-modules/transit-gateway/aws"

  name            = "shared-tgw"
  description     = "Shared Transit Gateway"
  amazon_side_asn = 64599

  transit_gateway_cidr_blocks = ["12.99.0.0/24"]

  enable_auto_accept_shared_attachments = false
  enable_sg_referencing_support         = false
  enable_multicast_support              = false
  share_tgw                              = false

  vpc_attachments = {
    for idx, vpc in module.vpc : "vpc-${idx}" => {
      vpc_id     = vpc.vpc_id
      subnet_ids = vpc.private_subnets

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true

      dns_support  = false
      ipv6_support = false

      tgw_vpc_attachment_tags = {
        Name = "tgw-attachment-to-vpc-${idx}"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}



# Define routes in private route tables to point to the transit gateway
resource "aws_route" "private_to_tgw" {
  for_each = {
    for idx, route in local.vpc_route_matrix : idx => route
  }

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id

  depends_on = [
    module.tgw
  ]
}
