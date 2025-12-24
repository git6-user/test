# this file creates multiple VPCs with public and private subnets using the terraform-aws-modules/vpc/aws module

data "aws_availability_zones" "region" {
    state = "available"
    }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"
  count   = length(var.vpc_cidrs)

  name = "Private-${count.index + 1}"
  cidr = var.vpc_cidrs[count.index]

  azs             = slice(data.aws_availability_zones.region.names, 0, var.required_avilability_zone)
  # in the beelow line for subnet 8,1 refer to /16,second octate of cidr block
  # ex: 10.0.0.0/16 -> 10.0.1.0/24 (16+8=24) 10.0.0.0 -> 10.0.1.0
  private_subnets = ["${cidrsubnet(var.vpc_cidrs[count.index], 8, 1)}", "${cidrsubnet(var.vpc_cidrs[count.index], 8, 2)}"]
  public_subnets  = ["${cidrsubnet(var.vpc_cidrs[count.index], 8, 3)}", "${cidrsubnet(var.vpc_cidrs[count.index], 8, 4)}"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
  private_subnet_tags = {
    Name = "Private-Subnet-${count.index + 1}"
  }

  tags = {
    Environment = "Private-${count.index + 1}"
  }
}

