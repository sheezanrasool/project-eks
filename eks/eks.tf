resource "aws_iam_role" "project-eks-role" {
  name = "project-eks-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "project-eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.project-eks-role.name
}

resource "aws_eks_cluster" "project-eks-cluster" {
  name     = "project-eks-cluster"
  role_arn = aws_iam_role.project-eks-role.arn
  vpc_config {
    subnet_ids              = var.subnet_ids
  }
  depends_on = [aws_iam_role_policy_attachment.project-eks-AmazonEKSClusterPolicy]
}
