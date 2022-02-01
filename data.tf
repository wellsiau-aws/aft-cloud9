data "aws_vpc" "aft_management_vpc" {
  filter {
    name   = "tag:Name"
    values = ["aft-management-vpc"]
  }
}

data "aws_subnet_ids" "aft_public_subnet_01" {
  vpc_id   = data.aws_vpc.aft_management_vpc.id
  filter {
    name   = "tag:Name"
    values = ["aft-vpc-public-subnet-01"]
  }
}

data "aws_instance" "cloud9-instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.cloud9-aft.id]
  }
}