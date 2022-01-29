provider "aws" {
  region = var.ct_home_region
}

resource "aws_iam_role" "cloud9-aft-role" {
  path = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "cloud9-aft-profile" {
  name = var.c9_instance_profile
  role = aws_iam_role.cloud9-aft-role.name
}

resource "aws_cloud9_environment_ec2" "cloud9-aft" {
  name = var.c9_instance_name
  instance_type = "t2.micro"
}

output "cloud9_ide" {
  value = "https://${var.ct_home_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.cloud9-aft.id}?region=${var.ct_home_region}"
}