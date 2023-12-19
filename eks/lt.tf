data "aws_ami" "eks_default" {
  count = 1
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_cluster_version}-v*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_template" "eks-launch-template" {
  name = "eks-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
      encrypted   = true
      volume_type = "gp3"
      delete_on_termination = true
    }
  }

  instance_type = "t2.micro"
  image_id      = data.aws_ami.eks_default[0].image_id
  

  vpc_security_group_ids = [aws_security_group.worker_sg.id] 
  monitoring {
    enabled = true
  }

   user_data = base64encode(data.template_file.userdata.rendered)

  tag_specifications {
    resource_type = "instance"
    tags        = merge(local.common_tags, local.worker_tags)
}
}



  data "template_file" "userdata" {
  template  = file("bootstrap.sh")
  

  vars = {
    CLUSTER_NAME   = var.cluster_name
    B64_CLUSTER_CA = aws_eks_cluster.project-eks-cluster.certificate_authority.0.data
    API_SERVER_URL = aws_eks_cluster.project-eks-cluster.endpoint
  }
}