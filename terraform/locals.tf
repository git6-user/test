# This file defines local values to manage EC2 instance distribution across multiple VPC
# examples based on the number of public and private instances specified per VPC
# private_instances_per_vpc = 8 i have 6 vpc i need to get 10 instances with 2 instances in 2 different vpcs public subnet and 8 instances in private subset(6 each vpc 1) and other 2 in any other vpc which means 2 vpcs private sub will have 4 and other private will have 4 each 1 instance


locals {
  vpc_count = length(module.vpc)

  # -------------------------------
  # PUBLIC INSTANCES (total count)
  # -------------------------------
  public_instances = [
    for i in range(var.public_instances_per_vpc) : {
      vpc_index = i % local.vpc_count                            # round-robin VPC
      subnet_id = module.vpc[i % local.vpc_count].public_subnets[0] # pick first public subnet in that VPC
      type      = "public"
    }
  ]

  # -------------------------------
  # PRIVATE INSTANCES (total count)
  # -------------------------------
  private_instances = [
    for i in range(var.private_instances_per_vpc) : {
      vpc_index = i % local.vpc_count                             # round-robin VPC
      subnet_id = module.vpc[i % local.vpc_count].private_subnets[0] # pick first private subnet in that VPC
      type      = "private"
    }
  ]

  # -------------------------------
  # Combine all instances for EC2 module
  # -------------------------------
  subnet_map = {
    for idx, inst in concat(local.public_instances, local.private_instances) :
    idx => inst
  }
}
# Define route matrix for VPC peering routes of transit gateway
locals {
  vpc_route_matrix = flatten([
    for i, vpc in module.vpc : [
      for j, other in module.vpc : {
        route_table_id = vpc.private_route_table_ids[0]
        destination    = other.vpc_cidr_block
      } if i != j
    ]
  ])
}
