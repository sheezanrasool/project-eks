variable "count_ec2_instance" {
  description = "number of ec2 instance"
  type        = number
  default     = 2
}

variable "ec2_name" {
  description = "Name of bastion"
  type        = list
  default     = ["bastion-nonprod-1a","bastion-nonprod-1b"]
}
variable "public_ip" {
  description = "Public Ip "
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {
    "Environment" = "Nonprod"
  }
}
variable "subnet_ids" {
  type    = list(string)
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
# variable "key_name" {
#   description = "Key name of Launch configuration"
#   type        = string
#   default     = "bastion-nonprod"
# }
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
  type = bool
  description = "(optional) describe your variable"
  default = false
}

variable "iam_instance_profile" {
  type = string
  default = "value"
}

variable "user_data" {
  
}

variable "security_group_name" {
  default = "bastion-sg"
}

variable "vpc_id" {
  default = ""
}

variable "sgtags" {
  default = {
    Name = "bastion-sg"
  }
}

variable "sgingress" {
  default = [
    {
      fromport   = 22
      toport     = 22
      protocol    = "tcp"
      cidrblocks  = ["0.0.0.0/0"]
      description = "22 port"
      self            = false
      security_groups = []
    },
    {
      fromport   = 23
      toport     = 23
      protocol    = "tcp"
      cidrblocks  = ["0.0.0.0/0"]
      description = "23 port"
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

variable "public_subnets" {
  type        = list(string)
  description = "Zones to launch our instances into"
  default     = [""]
}

variable "private_subnets" {
  type        = list(string)
  description = "Zones to launch our instances into"
  default     = [""]
}