variable "vpc_cidr_block" {
}

variable "vpc_name" {
}


variable "internet_gateway_name" {
}

variable "public_subnets" {
  description = "Map of public subnets"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
  default = {
    "subnet-1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      tag_name          = "public-subnet-1a"
    },
    "subnet-2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      tag_name          = "public-subnet-1b"
    },
  }
}

variable "private_subnets" {
  description = "Map of private subnets"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
    tag_name          = string
  }))
  default = {
    "subnet-3" = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1a"
      tag_name          = "private-subnet-1a"
    },
    "subnet-4" = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
      tag_name          = "private-subnet-1b"
    },
  }
}