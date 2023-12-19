resource "aws_vpc" "project-eks-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "project-eks-vpc"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-eks-vpc.id

  tags = {
    Name = "igw"
  }
}

locals {
 public_subnets = {
    "subnet-1" = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a", tag_name = "public-subnet-1a" }
    "subnet-2" = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b", tag_name = "public-subnet-1b" }
 }
 private_subnets = {
    "subnet-3" = { cidr_block = "10.0.3.0/24", availability_zone = "us-east-1a", tag_name = "private-subnet-1a" }
    "subnet-4" = { cidr_block = "10.0.4.0/24", availability_zone = "us-east-1b", tag_name = "private-subnet-1b" }
 }
}

resource "aws_subnet" "project-eks-public-subnet" {
  for_each = local.public_subnets

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.project-eks-vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
  }
}

resource "aws_subnet" "project-eks-private-subnet" {
  for_each = local.private_subnets

  cidr_block        = each.value.cidr_block
  vpc_id            = aws_vpc.project-eks-vpc.id
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
  }
}


