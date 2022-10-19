locals {
  # general
  stack_name = "test_ec2_bastion"
  env        = "dev"

  # instance profile
  s3_bucket_name = "account-junk-nonversioned"

  # baston
  disable_api_termination = false
  instance_type           = "t3.nano"
  key_name                = "macbook-key-pair"
  subnet_id               = "subnet-096d9d78fd5ebff5b"
  vpc_id                  = "vpc-0f51f9742ff792b79"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

# TODO: add perms as you build out bastion
data "aws_iam_policy_document" "additional" {
  statement {
    sid = "TestSid"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::account-keeps-nonversioned/"
    ]
  }
}

module "instance_profile" {
  source               = "git@github.com:Dslate88/tf-aws-instance-profile.git"
  stack_name           = local.stack_name
  env                  = local.env
  s3_bucket_name       = local.s3_bucket_name
  addl_policy_document = data.aws_iam_policy_document.additional.json
}

module "bastion" {
  source     = "./.."
  stack_name = local.stack_name
  env        = local.env

  ami                     = data.aws_ami.ubuntu.id
  disable_api_termination = local.disable_api_termination
  # iam_instance_profile    = local.instance_profile
  instance_type = local.instance_type
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  vpc_id        = local.vpc_id
}
