![Alt text](project-eks-Page-2.drawio.png)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.24.0 |

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
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Name of Launch configuration | `string` | `"ami-0759f51a90924c166"` | no |
| <a name="input_bastion_role_name"></a> [bastion\_role\_name](#input\_bastion\_role\_name) | Bastion Role Name | `string` | `"ec2_assume_role_bastion"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name | `string` | `"project-eks-cluster"` | no |
| <a name="input_count_ec2_instance"></a> [count\_ec2\_instance](#input\_count\_ec2\_instance) | number of ec2 instance | `number` | `2` | no |
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | Name of bastion | `list(any)` | <pre>[<br>  "bastion-1a",<br>  "bastion-1b"<br>]</pre> | no |
| <a name="input_eks-cluster-autoscaler"></a> [eks-cluster-autoscaler](#input\_eks-cluster-autoscaler) | Cluster Autoscaler | `string` | `"eks-cluster-autoscaler"` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | n/a | `string` | `"1.24"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | n/a | `string` | `"value"` | no |
| <a name="input_iam_instance_profile_required"></a> [iam\_instance\_profile\_required](#input\_iam\_instance\_profile\_required) | (optional) describe your variable | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Name of Launch configuration | `string` | `"t2.micro"` | no |
| <a name="input_internet_gateway_name"></a> [internet\_gateway\_name](#input\_internet\_gateway\_name) | Name for the Internet Gateway | `string` | `"igw"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Map of private subnets | <pre>map(object({<br>    cidr_block        = string<br>    availability_zone = string<br>    tag_name          = string<br>  }))</pre> | <pre>{<br>  "subnet-3": {<br>    "availability_zone": "us-east-1a",<br>    "cidr_block": "10.0.3.0/24",<br>    "tag_name": "private-subnet-1a"<br>  },<br>  "subnet-4": {<br>    "availability_zone": "us-east-1b",<br>    "cidr_block": "10.0.4.0/24",<br>    "tag_name": "private-subnet-1b"<br>  }<br>}</pre> | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Public Ip | `bool` | `true` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Map of public subnets | <pre>map(object({<br>    cidr_block        = string<br>    availability_zone = string<br>    tag_name          = string<br>  }))</pre> | <pre>{<br>  "subnet-1": {<br>    "availability_zone": "us-east-1a",<br>    "cidr_block": "10.0.1.0/24",<br>    "tag_name": "public-subnet-1a"<br>  },<br>  "subnet-2": {<br>    "availability_zone": "us-east-1b",<br>    "cidr_block": "10.0.2.0/24",<br>    "tag_name": "public-subnet-1b"<br>  }<br>}</pre> | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | n/a | `string` | `"bastion-sg"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Name of Launch configuration | `list(string)` | `[]` | no |
| <a name="input_sgegress"></a> [sgegress](#input\_sgegress) | n/a | `list` | <pre>[<br>  {<br>    "cidrblocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "",<br>    "fromport": 0,<br>    "protocol": -1,<br>    "security_groups": [],<br>    "self": false,<br>    "toport": 0<br>  }<br>]</pre> | no |
| <a name="input_sgingress"></a> [sgingress](#input\_sgingress) | n/a | `list` | <pre>[<br>  {<br>    "cidrblocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "22 port",<br>    "fromport": 22,<br>    "protocol": "tcp",<br>    "security_groups": [],<br>    "self": false,<br>    "toport": 22<br>  },<br>  {<br>    "cidrblocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "23 port",<br>    "fromport": 23,<br>    "protocol": "tcp",<br>    "security_groups": [],<br>    "self": false,<br>    "toport": 23<br>  }<br>]</pre> | no |
| <a name="input_sgtags"></a> [sgtags](#input\_sgtags) | n/a | `map` | <pre>{<br>  "Name": "bastion-sg"<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Zones to launch our instances into | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `any` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | volume size | `number` | `8` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | volume type | `string` | `"gp2"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name for the VPC Gateway | `string` | `"project-eks-vpc"` | no |
| <a name="input_worker-nodes-name"></a> [worker-nodes-name](#input\_worker-nodes-name) | Worker Nodes Name | `string` | `"project-eks-worker-nodes"` | no |

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
