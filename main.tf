provider "aws" {
  region = var.ct_home_region
}

module "vpc" {
  source  = "aws-ia/vpc/aws"
  version = "0.1.2"
  count   = local.vpc.is_create_new ? 1 : 0
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
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "aws_iam_instance_profile" "cloud9-aft-profile" {
  name = var.c9_instance_profile
  role = aws_iam_role.cloud9-aft-role.name
}

resource "aws_cloud9_environment_ec2" "cloud9-aft" {
  name          = var.c9_instance_name
  instance_type = "t2.micro"
  subnet_id     = local.vpc.is_create_new ? vpc.public_subnet_ids : null
}

data "aws_instance" "cloud9-instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.cloud9-aft.id]
  }
}