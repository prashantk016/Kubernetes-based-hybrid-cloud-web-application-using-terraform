#
# EKS Worker Nodes Resources
#  * EC2 Security Group to allow networking traffic
#

resource "aws_security_group" "final-project-node" {
  name        = "terraform-eks-final-project-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.final-project.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "terraform-eks-final-project-node",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "final-project-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.final-project-node.id}"
  source_security_group_id = "${aws_security_group.final-project-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "final-project-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.final-project-node.id}"
  source_security_group_id = "${aws_security_group.final-project-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}