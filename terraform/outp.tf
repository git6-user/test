# output "instance_ip" {
#     description = "Ec2 public ip"
#     #value = aws_instance.test.public_ip # this is output without for loop for single instance
#     value = [for i in aws_instance.test : i.public_ip] #using for loop with list
  
# }
# output "instance_dns" {
#     description = "Ec2 public dns"
#    # value = aws_instance.test.public_dns 
#    value = {for i in aws_instance.test : i.id => i.public_dns} # using for loop with map without each instance
#    #value = {for c,i in aws_instance.test : c => i.public_dns} # using for loop with map with each instance
   
# }
# output "instance_ip" {
#     description = "Ec2 public ip"
#     value = aws_instance.test[*].public_ip # generalized splat operator

# }

# output "vpc1" {
#     value = aws_vpc.vpc1.id
  
# }

# output "vpc2" {
#     value = aws_vpc.vpc2.id
  
# }

# output "vpc3" {
#     value = aws_vpc.vpc3.id
  
# }

# output "vpc1-subn1" {
#     value = aws_subnet.private_subnet1.id 
  
# }

# output "vpc1-subn2" {
#     value = aws_subnet.private_subnet2.id 
  
# }

# output "vpc1-subn3" {
#     value = aws_subnet.private_subnet3.id 
  
#}

output "vpc_ids" {
  value = data.aws_vpcs.my-vpcs[*].id
}

output "public_subnet_ids" {
  value = {
    for k, v in data.aws_subnets.public : k => v.ids
  }
}

output "private_subnet_ids" {
  value = {
    for k, v in data.aws_subnets.private : k => v.ids
  }
}
