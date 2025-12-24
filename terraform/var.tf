variable "environment" {
  default = "prod"
}
variable "list" {
    description = "value of ami"
    type        = list(string)
    default     = ["t2.micro", "t3.micro"]  
}
variable "map" {
    description = "value of ami"
    type        = map(string)
    default     = {
        dev = "t2.micro"
        prod = "t3.micro"
    }
  
}
variable "vpc_cidrs" {
  type = list(string)
  default = ["10.0.0.0/16", "13.0.0.0/16", "15.0.0.0/16"]
}
variable "public_instances_per_vpc" {
  description = "Number of public EC2 per VPC"
  type        = number
  default     = 2
#     validation {
#        condition     = var.public_instances_per_vpc <= length(flatten([for v in module.vpc : v.public_subnets]))
#        error_message = "Cannot create more public EC2 than available public subnets per VPC"
#   }
}

variable "private_instances_per_vpc" {
  description = "Number of private EC2 per VPC"
  type        = number
  default     = 3
#     validation {
#        condition     = var.private_instances_per_vpc <= length(flatten([for v in module.vpc : v.private_subnets]))
#        error_message = "Cannot create more private EC2 than available private subnets per VPC"
#   }
}
variable "required_avilability_zone" {
  type    = number
  default = 2
}
variable "vpcindex" {
  type    = number
  default = 0
}

