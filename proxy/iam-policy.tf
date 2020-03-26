// IAM policy document - Assume role policy
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

// IAM policy document - EIP permissions policy
data "aws_iam_policy_document" "eip_policy" {
  statement {
    sid = "1"

    actions = [
      "ec2:DescribeAddresses",
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:DescribeInstances",
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:DescribeNetworkInterfaces",
      "ec2:AssignPrivateIpAddresses",
      "ec2:UnassignPrivateIpAddresses",
    ]

    resources = ["*"]
  }
}

// IAM role - EIP role
resource "aws_iam_role" "eip_role" {
  name               = "hapee_eip_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

// IAM role policy - EIP role policy
resource "aws_iam_role_policy" "eip_role_policy" {
  name   = "hapee_eip_role_policy"
  role   = "${aws_iam_role.eip_role.id}"
  policy = "${data.aws_iam_policy_document.eip_policy.json}"
}

// IAM instance profile - EIP instance profile
resource "aws_iam_instance_profile" "eip_instance_profile" {
  name = "hapee_instance_profile"
  role = "${aws_iam_role.eip_role.id}"
}