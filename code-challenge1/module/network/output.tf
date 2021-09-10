output "krishi_project_vpc_id" {
    value = aws_vpc.main-vpc.id
}

output "public_subnet1A_id" {
    value = aws_subnet.main-pubsubnet1A.id
}

output "public_subnet1B_id" {
    value = aws_subnet.main-pubsubnet1B.id
}

output "private_subnet1A_id" {
    value = aws_subnet.main-privsubnet1A.id
}

output "private_subnet1B_id" {
    value = aws_subnet.main-privsubnet1B.id
}