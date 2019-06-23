#
# EKS Cluster Resources
#  * EC2 Security Group to allow networking traffic with EKS cluster
#

resource "aws_security_group" "final-project-cluster" {
  name        = "terraform-eks-final-project-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.final-project.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-final-project"
  }
}

resource "aws_security_group_rule" "final-project-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.final-project-cluster.id}"
  source_security_group_id = "${aws_security_group.final-project-node.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "final-project-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.final-project-cluster.id}"
  to_port           = 443
  type              = "ingress"
}