resource "aws_route_table" "private-1a" {
  vpc_id = aws_vpc.project-eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1a.id
  }
tags = {
    Name = "private-1a"
  }
}
  

resource "aws_route_table" "private-1b" {
  vpc_id = aws_vpc.project-eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1b.id
  }
  tags = {
    Name = "private-1b"
  }
}
  

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project-eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.project-eks-private-subnet["subnet-3"].id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.project-eks-private-subnet["subnet-4"].id
  route_table_id = aws_route_table.private-1b.id
}

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.project-eks-public-subnet["subnet-1"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.project-eks-public-subnet["subnet-2"].id
  route_table_id = aws_route_table.public.id
}
