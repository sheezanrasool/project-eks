terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name       = module.eks.eks_cluster_id
}
data "aws_eks_cluster" "eks_cluster" {
  name       = module.eks.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
  config_paths = ["config"]
}