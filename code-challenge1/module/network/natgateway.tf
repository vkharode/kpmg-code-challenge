# Create EIP's to associate with the NAT Gateways-

resource "aws_eip" "main-nateip-privsub1A" {
  tags = {
    "Name" = "main-NATEIP-PRIVSUB1A"
  }
}

resource "aws_eip" "main-nateip-privsub1B" {
 tags = {
     "Name" = "main-NATEIP-PRIVSUB1B"
 } 
}


# Crate NAT Gateway for resources in private subnet to talk to the Internet or other AWS Services.associate_with_private_ip

resource "aws_nat_gateway" "main-natgw-privsub1A" {
  allocation_id = aws_eip.main-nateip-privsub1A.id
  subnet_id = aws_subnet.main-privsubnet1A.id

  tags = {
    "Name" = "main-NATGW-1A"
  }
}


resource "aws_nat_gateway" "main-natgw-privsub1B" {
  allocation_id = aws_eip.main-nateip-privsub1B.id
  subnet_id = aws_subnet.main-privsubnet1B.id

  tags = {
    "Name" = "main-NATGW-1B"
  }
}
