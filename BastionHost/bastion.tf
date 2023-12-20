resource "aws_iam_role" "ec2_assume_role_bastion" {
  name = var.bastion_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      Name = var.bastion_role_name
  }
}

resource "aws_iam_instance_profile" "ec2_assume_role_profile" {
  name = "ec2_assume_role_profile"
  role = "${aws_iam_role.ec2_assume_role_bastion.name}"
}

resource "aws_iam_role_policy" "eks_ecr_access_policy" {
  name = "eks_ecr_access_policy"
  role = "${aws_iam_role.ec2_assume_role_bastion.id}"
  policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecr:*",
            "Resource": "*"
        }

    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonSSMFullAccess" {
  role       = aws_iam_role.ec2_assume_role_bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.ec2_assume_role_bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "ec2" {
  count                       = var.count_ec2_instance 
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_ip
  user_data = var.user_data
  subnet_id                   =  var.public_subnets[count.index]
  vpc_security_group_ids      = [aws_security_group.securitygroup.id] #var.security_groups
  iam_instance_profile        =  "${aws_iam_instance_profile.ec2_assume_role_profile.name}"
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  
  tags = merge(
    {
      Name = format("%s", element(var.ec2_name,count.index))
    },
    {
      PROVISIONER = "Terraform"
    },
  )
}