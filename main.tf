#Bastion Host Module
# --------------------
#This module creates an Amazon Virtual Private Cloud (VPC) with public and 
#private subnets in two availability zones (AZs) in the `us-east-1` region.

module "vpc" {
  source                = "./vpc"
  vpc_cidr_block        = var.vpc_cidr_block
  vpc_name              = var.vpc_name
  internet_gateway_name = var.internet_gateway_name
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  
}

#Bastion Host Module
# --------------------
# This module deploys a bastion host, in two Public Subnets across
# Availability Zones (AZs) us-east-1a and us-east-1b. The use of multiple subnets ensures
# high availability and redundancy.

module "bastion" {
  source              = "./BastionHost"
  ec2_name            = var.ec2_name
  count_ec2_instance  = 2
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  public_ip           = true
  user_data           = file("install_needful.sh")
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnet_ids
  private_subnets     = module.vpc.private_subnet_ids
  bastion_role_name   = var.bastion_role_name
  volume_size         = var.volume_size
  volume_type         = var.volume_type
  security_group_name = var.security_group_name
  sgtags = {
    Name = var.security_group_name
  depends_on = module.vpc
  }
}

# EKS Cluster Module
# -------------------
# This module provisions an Amazon Elastic Kubernetes Service (EKS) cluster in private
# subnets across two Availability Zones (AZs). EKS is a fully managed Kubernetes service
# that simplifies the deployment, management, and scaling of containerized applications using
# Kubernetes.

module "eks" {
  source                 = "./eks"
  subnet_ids             = module.vpc.private_subnet_ids
  eks_cluster_version    = var.eks_cluster_version
  cluster_name           = var.cluster_name
  bastion_sg_id          = module.bastion.sgid
  vpc_id                 = module.vpc.vpc_id
  bastion_role_arn       = module.bastion.bastion_role_arn
  eks-cluster-autoscaler = var.eks-cluster-autoscaler
  worker-nodes-name      = var.worker-nodes-name
  depends_on = [module.vpc, module.bastion]
}

