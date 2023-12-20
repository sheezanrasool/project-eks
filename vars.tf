variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name for the VPC Gateway"
  default     = "project-eks-vpc"
}


variable "internet_gateway_name" {
  description = "Name for the Internet Gateway"
  default     = "igw"
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
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
  type = map(object({
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


variable "vpc_id" {
  default = ""
}


variable "count_ec2_instance" {
  description = "number of ec2 instance"
  type        = number
  default     = 2
}

variable "ec2_name" {
  description = "Name of bastion"
  type        = list(any)
  default     = ["bastion-1a", "bastion-1b"]
}
variable "public_ip" {
  description = "Public Ip "
  type        = bool
  default     = true
}


variable "subnet_ids" {
  type        = list(string)
  description = "Zones to launch our instances into"
  default     = [""]
}
variable "volume_size" {
  description = "volume size"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "volume type"
  type        = string
  default     = "gp2"
}

variable "ami_id" {
  description = "Name of Launch configuration"
  type        = string
  default     = "ami-0759f51a90924c166"
}

variable "instance_type" {
  description = "Name of Launch configuration"
  type        = string
  default     = "t2.micro"
}
variable "security_groups" {
  description = "Name of Launch configuration"
  type        = list(string)
  default     = []
}
variable "iam_instance_profile_required" {
  type        = bool
  description = "(optional) describe your variable"
  default     = false
}

variable "iam_instance_profile" {
  type    = string
  default = "value"
}

variable "user_data" {

}

variable "security_group_name" {
  default = "bastion-sg"
}

variable "sgtags" {
  default = {
    Name = "bastion-sg"
  }
}

variable "sgingress" {
  default = [
    {
      fromport        = 22
      toport          = 22
      protocol        = "tcp"
      cidrblocks      = ["0.0.0.0/0"]
      description     = "22 port"
      self            = false
      security_groups = []
    },
    {
      fromport        = 23
      toport          = 23
      protocol        = "tcp"
      cidrblocks      = ["0.0.0.0/0"]
      description     = "23 port"
      self            = false
      security_groups = []
    }
  ]
}

variable "sgegress" {
  default = [
    {
      description     = ""
      fromport        = 0
      toport          = 0
      protocol        = -1
      cidrblocks      = ["0.0.0.0/0"]
      self            = false
      security_groups = []
    }
  ]
}

variable "bastion_role_name" {
  description = "Bastion Role Name"
  default     = "ec2_assume_role_bastion"
}

variable "worker-nodes-name" {
  description = "Worker Nodes Name"
  default     = "project-eks-worker-nodes"
}

variable "eks-cluster-autoscaler" {
  description = "Cluster Autoscaler"
  default     = "eks-cluster-autoscaler"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "project-eks-cluster"
  type        = string
}

variable "eks_cluster_version" {
  default = "1.24"
}