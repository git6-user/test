resource "aws_vpc" "vpc1" {
  
}

resource "aws_vpc" "vpc2" {
  
}

resource "aws_vpc" "vpc3" {
  
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  tags = {
    Name = "Private-Subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc2.id
  tags = {
    Name = "Private-Subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  vpc_id     = aws_vpc.vpc3.id
  tags = {
    Name = "Private-Subnet3"
  }
}

