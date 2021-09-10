# Create Bastion Host Security group.

resource "aws_security_group" "main-bastionhosts-sg" {
  vpc_id = aws_vpc.main-vpc.id
  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "To allow SSH connection to bastion host"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    ipv6_cidr_blocks = [ ]
    prefix_list_ids = [ ]
    security_groups = [ ]
    self = false
  } ]
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    "Name" = "Security Group For Bastion Hosts"
  }
}

# Create Bastion Host in eu-west-1a public subnet

resource "aws_instance" "main-bastionhost-1a" {
  ami = "ami-0e3f630ea5003ecf3"
  instance_type = "t2.micro"
  key_name = "Migration"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.main-bastionhosts-sg.id]
  subnet_id = aws_subnet.main-pubsubnet1A.id
  tags = {
    "Name" = "main-BASTION-HOST-1A"
  }
}

# Create Bastion Host in eu-west-1b public subnet

resource "aws_instance" "main-bastionhost-1b" {
  ami = "ami-0e3f630ea5003ecf3"
  instance_type = "t2.micro"
  key_name = "Migration"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.main-bastionhosts-sg.id]
  subnet_id = aws_subnet.main-pubsubnet1B.id
  tags = {
    "Name" = "main-BASTION-HOST-1B"
  }
}