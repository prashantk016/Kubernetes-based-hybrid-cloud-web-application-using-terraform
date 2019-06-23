#
# EKS Cluster Resources
#  * EKS Cluster
#
#  It can take a few minutes to provision on AWS

resource "aws_eks_cluster" "final-project" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.final-project-cluster.arn}"

  vpc_config {
    security_group_ids = flatten(["${aws_security_group.final-project-cluster.id}"])
    subnet_ids = flatten(["${aws_subnet.final-project.*.id}"])
  }

  depends_on = [
    "aws_iam_role_policy_attachment.final-project-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.final-project-cluster-AmazonEKSServicePolicy",
  ]
}
