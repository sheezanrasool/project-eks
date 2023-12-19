resource "aws_eip" "nat1" {
  domain = "vpc"

  tags = {
    Name = "nat1"
  }
}

resource "aws_eip" "nat2" {
  domain = "vpc"

  tags = {
    Name = "nat2"
  }
}


resource "aws_nat_gateway" "nat-1a" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.project-eks-public-subnet["subnet-1"].id

  tags = {
    Name = "nat-1a"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-1b" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.project-eks-public-subnet["subnet-2"].id

  tags = {
    Name = "nat-1b"
  }

  depends_on = [aws_internet_gateway.igw]
}