resource "aws_security_group" "vpc-sg-pri" {
    count  = length(module.vpc)
    name   = "vpc-ssh-sg-${count.index}"
    description = "Allow ssh traffic"
    vpc_id      = module.vpc[count.index].vpc_id
    ingress {
        description = "Allow port 22 for SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description      = "Allow ICMP Ping"
        from_port        = -1
        to_port          = -1
        protocol         = "icmp"
        cidr_blocks      = ["0.0.0.0/0"]  # Allow from anywhere
    }
    
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "vpc-web-sg-pub" {  
    name        = "vpc-web-sg-${count.index}"
    count  = length(module.vpc)
    description = "Allow web traffic"
    vpc_id      = module.vpc[count.index].vpc_id
    ingress {
        description = "Allow port 80 for HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow port 443 for HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow port 22 for SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
        description      = "Allow ICMP Ping"
        from_port        = -1
        to_port          = -1
        protocol         = "icmp"
        cidr_blocks      = ["0.0.0.0/0"]  # Allow from anywhere
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}