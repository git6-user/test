output "instance_ip" {
    description = "Ec2 public ip"
    #value = aws_instance.test.public_ip # this is output without for loop for single instance
    value = [for i in aws_instance.test : i.public_ip] #using for loop with list
  
}
output "instance_dns" {
    description = "Ec2 public dns"
   # value = aws_instance.test.public_dns 
   value = {for i in aws_instance.test : i.id => i.public_dns} # using for loop with map without each instance
   #value = {for c,i in aws_instance.test : c => i.public_dns} # using for loop with map with each instance
   
}
output "instance_ip" {
    description = "Ec2 public ip"
    value = aws_instance.test[*].public_ip # generalized splat operator

}