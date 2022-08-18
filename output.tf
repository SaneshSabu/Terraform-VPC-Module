output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public-2.id
} 

output "public_subnet_3_id" {
  value = aws_subnet.public-3.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private-1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private-2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private-3.id
}
