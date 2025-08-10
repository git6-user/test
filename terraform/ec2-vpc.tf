terraform {
    required_version = "~> 1.0.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}
provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "test" {
    ami = data.aws_ami.latest_amazon_linux
    #instance_type = var.list[0] # Using the list variable for instance type
    instance_type = var.map.prod # Using the map variable for instance type
    key_name = "eks-keypair"
    vpc_security_group_ids = [awsaws_security_group.vpc-sg.id, aws_security_group.vpc-web-sg.id]
    count = 2
    tags = {
        Name = "PrivateInstance-${count.index}"
    }
}



