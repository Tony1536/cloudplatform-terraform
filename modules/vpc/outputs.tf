output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.cloudplatform_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id
  ]
}
