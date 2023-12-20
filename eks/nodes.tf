resource "aws_iam_role" "project-eks-nodes-role" {
  name = "eks-node-group-nodes-role"

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
  role       = aws_iam_role.project-eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.project-eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.project-eks-nodes-role.name
}

resource "aws_eks_node_group" "project-eks-worker-nodes" {
  cluster_name    = aws_eks_cluster.project-eks-cluster.name
  node_group_name = var.worker-nodes-name
  node_role_arn   = aws_iam_role.project-eks-nodes-role.arn
  subnet_ids      = var.subnet_ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {Name : "project-eks-cluster", 
         "kubernetes.io/cluster/${var.cluster_name}" : "owned" , 
         "k8s.io/cluster-autoscaler/${var.cluster_name}" : "owned" , 
         "k8s.io/cluster-autoscaler/enabled": "true"
         }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.project-eks-cluster
  ]
}


