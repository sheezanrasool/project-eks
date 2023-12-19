output "sgid" {
  value = aws_security_group.securitygroup.id
}

output "bastion_publicIP" {
    value = aws_instance.ec2.*.public_ip
}

output "bastion_role_arn" {
  value = aws_iam_role.ec2_assume_role_bastion.arn
}