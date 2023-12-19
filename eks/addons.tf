variable "tags" {
    default = {
        Name = "EKS-ADDONS"
    }
}

resource "aws_eks_addon" "vpc_cni" {

  cluster_name      = aws_eks_cluster.project-eks-cluster.name
  addon_name        = "vpc-cni"
  resolve_conflicts_on_update = "PRESERVE"
  resolve_conflicts_on_create = "OVERWRITE"
  # resolve_conflicts = "OVERWRITE"
  addon_version     = data.aws_eks_addon_version.vpc_cni.version
  #addon_version     = var.eks_vpc-cni

  tags = var.tags
}

resource "aws_eks_addon" "kube_proxy" {


  cluster_name      = aws_eks_cluster.project-eks-cluster.name
  addon_name        = "kube-proxy"
  resolve_conflicts_on_update = "PRESERVE"
  resolve_conflicts_on_create = "OVERWRITE"
  addon_version     = data.aws_eks_addon_version.kube_proxy.version
  #addon_version     = var.eks_kube-proxy

  tags = var.tags
}

resource "aws_eks_addon" "coredns" {


  cluster_name      = aws_eks_cluster.project-eks-cluster.name
  addon_name        = "coredns"
  resolve_conflicts_on_update = "PRESERVE"
    resolve_conflicts_on_create = "OVERWRITE"
  addon_version     = data.aws_eks_addon_version.coredns.version
  #addon_version     = var.eks_coredns

  tags = var.tags
}


resource "aws_eks_addon" "ebs_csi_driver" {


  cluster_name      = aws_eks_cluster.project-eks-cluster.name
  addon_name        = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  addon_version     = data.aws_eks_addon_version.ebs_csi.version
  #addon_version     = var.eks_ebs_csi

  tags = var.tags
}


################
## Data Block ##
################

data "aws_eks_addon_version" "vpc_cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.project-eks-cluster.version
  most_recent        = true
}

data "aws_eks_addon_version" "kube_proxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.project-eks-cluster.version
  most_recent        = true
}

data "aws_eks_addon_version" "coredns" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.project-eks-cluster.version
  most_recent        = true
}

data "aws_eks_addon_version" "ebs_csi" {
  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = aws_eks_cluster.project-eks-cluster.version
  most_recent        = true
}