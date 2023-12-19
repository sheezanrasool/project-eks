module "vpc" {
  source = "./vpc"
}

module "bastion" {
  source              = "./BastionHost"
  ec2_name            = ["bastion-nonprod-1a", "bastion-nonprod-1b"] #public subnets
  count_ec2_instance  = 2
  ami_id              = "ami-0759f51a90924c166"
  instance_type       = "t2.micro"
  public_ip           = true
  user_data           = file("install_needful.sh")
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnet_ids
  private_subnets     = module.vpc.private_subnet_ids
  volume_size         = 20
  volume_type         = "gp3"
  security_group_name = "bastion-sg"
  sgtags = {
    Name = "bastion-sg"
  }
}

module "eks" {
  source = "./eks"
  subnet_ids =  module.vpc.private_subnet_ids
  cluster_name            = "project-eks-cluster"
  bastion_sg_id = module.bastion.sgid
  vpc_id              = module.vpc.vpc_id
  bastion_role_arn = module.bastion.bastion_role_arn
  eks-cluster-autoscaler = "eks-cluster-autoscaler"
  kms_grant = "eks"
  common_tags = { Env : "POC", Owner : "Sheezan", Project : "Project-EKS"}
  worker_tags = { Name : "Sheezan", "kubernetes.io/cluster/project-eks-cluster" : "owned" , "k8s.io/cluster-autoscaler/project-eks-cluster" : "owned" , "k8s.io/cluster-autoscaler/enabled": "true"}
  node_groups = {
    "NG-ONE" = {
      subnets          = module.vpc.private_subnet_ids #private subnets
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      capacity_type    = "ON_DEMAND"
      disk_size      = null
    }
    
  }
  user_arn = "arn:aws:iam::053146050864:user/sheezan" #user arn for kms key
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.eks_cluster_id
  depends_on = [ module.bastion ]
}
data "aws_eks_cluster" "eks" {
  name = module.eks.eks_cluster_id
  depends_on = [module.bastion]
}