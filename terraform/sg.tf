resource "aws_security_group" "vpc-sg" {
    name        = "vpc-ssh-sg"
    description = "Allow ssh traffic"
    vpc_id      = aws_vpc.main.id
    ingress {
        description = "Allow port 22 for SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0/0"]
    }
    
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0/0"]
    }
}

resource "aws_security_group" "vpc-web-sg" {  
    name        = "vpc-web-sg"
    description = "Allow web traffic"
    ingress {
        description = "Allow port 80 for HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0/0"]
    }
    ingress {
        description = "Allow port 443 for HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0/0"]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0/0"]
    }
  
}