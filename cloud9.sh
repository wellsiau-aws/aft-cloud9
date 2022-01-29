#!/bin/bash
set -e

if [[ $# -eq 0 ]] ; then
    echo 'Please include the CT Home region, i.e. us-east-1'
    exit 1
fi

# install terraform
echo "Installing Terraform"
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# download terraform file
#git clone https://github.com/wellsiau-aws/aft-cloud9.git
#cd aft-cloud9

# get CT home region 
export TF_VAR_ct_home_region=$1

# Run Terraform
terraform init
terraform apply -auto-approve

# Attach role to Cloud9 instance
export CLOUD9_EC2=`terraform output -raw cloud9_instance_id`
export CLOUD9_INSTANCE_PROFILE=`terraform output -raw cloud9_instance_profile`
#echo $CLOUD9_EC2
#echo $CLOUD9_INSTANCE_PROFILE
aws ec2 associate-iam-instance-profile --iam-instance-profile Arn=$CLOUD9_INSTANCE_PROFILE --instance-id $CLOUD9_EC2 --region $TF_VAR_ct_home_region

echo "Cloud9 is ready, use the URL below to access it"
terraform output cloud9_ide