# project-eks


# Terraform EKS Cluster Deployment

This repository contains Terraform code to deploy an Amazon EKS (Elastic Kubernetes Service) cluster on AWS. The infrastructure includes a VPC, public and private subnets, bastion hosts, and worker nodes in an autoscaling group.

## Modules

### VPC Module (`vpc`)

The VPC module creates a Virtual Private Cloud with public and private subnets across multiple availability zones.

module "vpc" {
  source = "./vpc"
}

Bastion Host Module (bastion)
The Bastion module deploys EC2 instances acting as bastion hosts in the public subnets. These instances provide secure access to the private resources within the VPC.

module "bastion" {
  source              = "./BastionHost"
  ec2_name            = ["bastion-nonprod-1a", "bastion-nonprod-1b"]
  count_ec2_instance  = 2
  # ... (other parameters)
}
## EKS Module (eks)
The EKS module creates the EKS cluster, worker nodes, and necessary configurations.

## GitHub Actions Pipeline
The repository is configured with GitHub Actions to automate the deployment of the EKS cluster whenever changes are pushed to the main branch.

Workflow File: .github/workflows/ci.yml

## Access the EKS Cluster:

After successful deployment, use the kubectl command with the generated kubeconfig file to interact with your EKS cluster.

aws eks --region <region> update-kubeconfig --name <cluster-name>
kubectl get nodes
