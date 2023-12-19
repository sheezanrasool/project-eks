
![project-eks-Page-2 drawio](https://github.com/sheezanrasool/project-eks/assets/61121312/5c927b58-cd5f-428c-ab07-d58848e3aebd)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./BastionHost | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Zones to launch our instances into | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Zones to launch our instances into | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_publicIP"></a> [bastion\_publicIP](#output\_bastion\_publicIP) | n/a |
| <a name="output_bastion_role_arn"></a> [bastion\_role\_arn](#output\_bastion\_role\_arn) | n/a |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | Cluster IAM Role ARN |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | EKS resource ARN |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | EKS cluster ID |
| <a name="output_eks_security_group_id"></a> [eks\_security\_group\_id](#output\_eks\_security\_group\_id) | SG ID |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Endpoint for EKS cluster |
| <a name="output_oidc_arn"></a> [oidc\_arn](#output\_oidc\_arn) | n/a |
| <a name="output_private_subnet"></a> [private\_subnet](#output\_private\_subnet) | Private Subnet ID |
| <a name="output_public_subnet"></a> [public\_subnet](#output\_public\_subnet) | Public Subnet ID |
| <a name="output_sgid"></a> [sgid](#output\_sgid) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
