# Create public subnets in 	us-east-1a and and us-east-1b

resource "aws_subnet" "main-pubsubnet1A" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.pub_subnet1a_cidr
  availability_zone = "	us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "main-PUBSUBNET1A"
     Terraform = "True"
  }
}

resource "aws_subnet" "main-pubsubnet1B" {
  vpc_id = aws_vpc.main-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = var.pub_subnet1b_cidr
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "main-PUBSUBNET1B"
     Terraform = "True"
  }
}


# Create private subnets in 	us-east-1a and and us-east-1b

resource "aws_subnet" "main-privsubnet1A" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = var.priv_subnet1a_cidr
  availability_zone = "	us-east-1a"
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "main-PRIVSUBNET1A"
     Terraform = "True"
  }
}

resource "aws_subnet" "main-privsubnet1B" {
  vpc_id = aws_vpc.main-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = var.priv_subnet1b_cidr
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "main-PRIVSUBNET1B"
     Terraform = "True"
  }
}