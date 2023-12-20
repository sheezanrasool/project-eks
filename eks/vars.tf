variable "subnet_ids" {
  description = "Zones to launch our instances into"
  default     = [""]
}

variable "vpc_id" {
  default = ""
}

variable "eks_cluster_version" {
}

variable "bastion_sg_id"{
  
}

variable "cluster_name" {
}


variable "eks-cluster-autoscaler"{

}

variable "bastion_role_arn"{

}

variable "worker-nodes-name" {
  }