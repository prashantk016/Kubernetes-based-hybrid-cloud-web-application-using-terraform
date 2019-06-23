# This data source is included for ease of sample architecture deployment
# and can be swapped out as necessary.
data "aws_region" "current" {}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  final-project-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.final-project.endpoint}' --b64-cluster-ca '${aws_eks_cluster.final-project.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}

resource "aws_launch_configuration" "final-project" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.final-project-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "terraform-eks-final-project"
  security_groups             = ["${aws_security_group.final-project-node.id}"]
  user_data_base64            = "${base64encode(local.final-project-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}