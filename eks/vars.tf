variable "subnet_ids" {
  description = "Zones to launch our instances into"
  default     = [""]
}

variable "vpc_id" {
  default = ""
}

variable "eks_cluster_version" {
  default = "1.24"
}

variable "bastion_sg_id"{
  
}
variable "node_groups" {
  description = "Paramters which are required for creating node group"
  type        = any
  default = {
    "NG_ONE" = {
      subnets          = [""]
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      capacity_type    = "ON_DEMAND"
      tags             = {
        "Name"         = "project-eks-workernode"
        "Environment"  = "POC"
      }
    }
  }
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "project-eks-cluster"
  type        = string
}

variable "common_tags"{

}

variable "worker_tags"{

}

#kms

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}

variable "description" {
  type        = string
  default     = "For EKS CLuster"
  description = "The description of the key as viewed in AWS console"
}

variable "policy" {
  type        = string
  default     = ""
  description = "A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`."
}

variable "multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "alias" {
  type        = string
  description = "Provide the alias for the KMS"
  default     = "EKS-test"
}

variable "create_kms" {
  description = "If true it will create KMS for EKS"
  type        = bool
  default     = true
}

variable "kms_arn" {
  description = "Provide custom KMS ARN"
  type        = string
  default     = ""
}

variable "user_arn" {
  default = "arn:aws:iam::053146050864:user/sheezan"
}

variable "create_encryption_config" {
  description = "Provide whether to create encryption config or not"
  type        = bool
  default     = true
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type = map(object({
    resources = list(string)
  }))
  default = {
    "encrypt" = {
      resources = ["secrets"]
    }
  }
}


variable "kms_grant" {
  
}

variable "eks-cluster-autoscaler"{

}

variable "bastion_role_arn"{

}