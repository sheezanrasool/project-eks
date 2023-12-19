output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnet" {
  value       = module.vpc.public_subnet_ids
  description = "Public Subnet ID"
}

output "private_subnet" {
  value       = module.vpc.private_subnet_ids
  description = "Private Subnet ID"
}

output "sgid" {
  value = module.bastion.sgid
}

output "bastion_publicIP" {
    value = module.bastion.*.bastion_publicIP
}

output "bastion_role_arn" {
  value = module.bastion.bastion_role_arn
}

# eks
output "endpoint" {
  description = "Endpoint for EKS cluster"
  value       = module.eks.endpoint
}

output "cluster_iam_role_arn" {
  description = "Cluster IAM Role ARN"
  value       = module.eks.cluster_iam_role_arn
}

output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.eks_cluster_id
}
# output "eks_cluster_id_2" {
#   description = "EKS cluster 2 ID"
#   value       = module.eks2.eks_cluster_id
# }

output "eks_cluster_arn" {
  description = "EKS resource ARN"
  value       = module.eks.eks_cluster_arn
}

output "eks_security_group_id" {
  description = "SG ID"
  value       = module.eks.eks_security_group_id
}

output "oidc_arn" {
  value = module.eks.oidc_arn
}
