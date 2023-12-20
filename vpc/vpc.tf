resource "aws_vpc" "project-eks-vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-eks-vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_subnet" "project-eks-public-subnet" {
  for_each = var.public_subnets

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.project-eks-vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
  }
}

resource "aws_subnet" "project-eks-private-subnet" {
  for_each = var.private_subnets

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.project-eks-vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
  }
}


