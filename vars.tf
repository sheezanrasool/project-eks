variable "public_subnets" {
  type        = list(string)
  description = "Zones to launch our instances into"
  default     = [""]
}

variable "vpc_id" {
  default = ""
}

variable "private_subnets" {
  type        = list(string)
  description = "Zones to launch our instances into"
  default     = [""]
}