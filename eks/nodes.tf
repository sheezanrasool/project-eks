locals {
  common_tags = var.common_tags
  worker_tags = var.worker_tags
}

resource "aws_iam_role" "project-eks-nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.project-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.project-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.project-eks-nodes.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.project-eks-cluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.project-eks-nodes.arn

  subnet_ids = var.subnet_ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    id      = aws_launch_template.eks-launch-template.id
    version = aws_launch_template.eks-launch-template.latest_version
  }
  tags                   = merge(local.common_tags, local.worker_tags)

  labels = {
    role = "general"
  }


  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_security_group" "worker_sg" {
  name        = "${aws_eks_cluster.project-eks-cluster.name}-worker-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker_sg_rules" {
  for_each                 = local.sg_worker_rules
  description              = each.value.description
  type                     = each.value.type
  from_port                = each.value.f_port
  to_port                  = each.value.t_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.worker_sg.id
  source_security_group_id = each.value.source_security_group_id
  self                     = each.value.self
  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
}

locals {
  sg_worker_rules = {
    rule1 = {
      t_port                     = 22
      f_port                    = 22
      description              = "Allow ssh access from bastion to worker nodes"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = var.bastion_sg_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule2 = {
      t_port                     = 443
      f_port                    = 443
      description              = "Cluster Default Rules"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule3 = {
      f_port                     = 10250
      t_port                   = 10250
      description              = "Cluster Default Rules"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule4 = {
      f_port                     = 53
      t_port                    = 53
      description              = "Cluster Default Rules for CoreDNS"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule5 = {
      f_port                     = 9443
      t_port                    = 9443
      description              = "Cluster Default Rules"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule6 = {
      f_port                     = 4443
      t_port                   = 4443
      description              = "Metrics Server Port"
      type                     = "ingress"
      protocol                 = "tcp"
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule7 = {
      f_port                     = 0
      t_port                    = 0
      description              = "Allow access to self"
      type                     = "ingress"
      protocol                 = -1
      source_security_group_id = null
      self                     = true
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule8 = {
      f_port                     = 0
      t_port                   = 0
      description              = "Outbound Rule for workers"
      type                     = "egress"
      protocol                 = -1
      source_security_group_id = null
      self                     = null
      cidr_blocks              = ["0.0.0.0/0"]
      ipv6_cidr_blocks         = ["::/0"]
    },
    rule9 = {
      f_port                     = 0
      t_port                    = 0
      description              = "Allow access to eks master"
      type                     = "ingress"
      protocol                 = -1
      source_security_group_id = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
      self                     = null
      cidr_blocks              = null
      ipv6_cidr_blocks         = null
    },
    rule10 = {
      f_port                     = 0
      t_port                   = 65535
      description              = "starhub-ntp"
      type                     = "ingress"
      protocol                 = "udp"
      source_security_group_id = null
      self                     = null
      cidr_blocks              = ["10.251.2.155/32"]
      ipv6_cidr_blocks         = null
    },
    rule11 = {
      f_port                     = 0
      t_port                    = 65535
      description              = "starhub-ntp"
      type                     = "ingress"
      protocol                 = "udp"
      source_security_group_id = null
      self                     = null
      cidr_blocks              = ["172.31.0.155/32"]
      ipv6_cidr_blocks         = null
    }
  }
}
