output "endpoint" {
  description = "Endpoint for EKS cluster"
  value       = aws_eks_cluster.project-eks-cluster.endpoint
}

output "cluster_iam_role_arn" {
  description = "Cluster IAM Role ARN"
  value       = aws_iam_role.project-eks-role.arn
}

output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.project-eks-cluster.id
}

output "eks_cluster_arn" {
  description = "EKS resource ARN"
  value       = aws_eks_cluster.project-eks-cluster.arn
}

output "eks_security_group_id" {
  description = "SG ID"
  value       = aws_eks_cluster.project-eks-cluster.vpc_config[0].cluster_security_group_id
}


output "oidc_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}
