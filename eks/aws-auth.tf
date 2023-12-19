data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.project-eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.project-eks-cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}


resource "kubernetes_config_map" "aws_auth" {
  
  depends_on = [ aws_eks_cluster.project-eks-cluster ]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  #data = local.aws_auth_configmap_data
  data = {
    "mapRoles" = yamlencode(local.maproles)
  }

  lifecycle {
    # We are ignoring the data here since we will manage it with the resource below
    # This is only intended to be used in scenarios where the configmap does not exist
    ignore_changes = [data]
  }

}

resource "kubernetes_config_map_v1_data" "aws_auth" {

  force = true

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    "mapRoles" = yamlencode(local.maproles)
  }

  depends_on = [
    # Required for instances where the configmap does not exist yet to avoid race condition
    kubernetes_config_map.aws_auth,
  ]  
}


locals {
  maproles = concat([
    {
      rolearn  = "${aws_iam_role.project-eks-nodes.arn}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }],
    [
    {
      rolearn  = var.bastion_role_arn,
      username = "system:admin",
      groups   = ["system:masters"]
      }]
  )
}
