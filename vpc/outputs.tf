output "vpc_id" {
  value       = aws_vpc.project-eks-vpc.id 
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = values(aws_subnet.project-eks-public-subnet)[*].id 
  description = "Public Subnet ID"
}

output "private_subnet_ids" {
  value       = values(aws_subnet.project-eks-private-subnet)[*].id 
  description = "Private Subnet ID"
}