data "aws_vpcs" "my-vpcs" {}

# Loop through those VPC IDs to get detailed info
data "aws_vpc" "my-vpc" {
  for_each = toset(data.aws_vpcs.my-vpcs.ids)
  id       = each.value
}

data "aws_subnets" "vpcsubnets" {
  for_each = data.aws_vpc.my-vpc

  filter {
    name   = "vpc-id"
    values = [each.value.id]
  }
}

data "aws_subnet" "vpcsubnet" {
  for_each = toset(flatten([
    for vpc, subnets in data.aws_subnets.vpcsubnets : subnets.ids
  ]))
  id = each.value
}

# # Get public subnets for each VPC
# data "aws_subnets" "public" {
#   for_each = data.aws_vpc.vpc

#   filter {
#     name   = "vpc-id"
#     values = [each.value.id]
#   }

#   filter {
#     name   = "tag:Type"
#     values = ["*plc"]
#   }
# }

# # Get private subnets for each VPC
# data "aws_subnets" "private" {
#   for_each = data.aws_vpc.vpc

#   filter {
#     name   = "vpc-id"
#     values = [each.value.id]
#   }

#   filter {
#     name   = "tag:Type"
#     values = ["*prvt"]
#   }
# }