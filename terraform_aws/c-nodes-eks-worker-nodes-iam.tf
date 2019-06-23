#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#

resource "aws_iam_role" "final-project-node" {
  name = "terraform-eks-final-project-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "final-project-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.final-project-node.name}"
}

resource "aws_iam_role_policy_attachment" "final-project-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.final-project-node.name}"
}

resource "aws_iam_role_policy_attachment" "final-project-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.final-project-node.name}"
}

resource "aws_iam_instance_profile" "final-project-node" {
  name = "terraform-eks-final-project"
  role = "${aws_iam_role.final-project-node.name}"
}