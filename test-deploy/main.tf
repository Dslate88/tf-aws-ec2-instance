locals {
  stack_name = "test"
  env        = "dev"

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

# TODO: create additional sg_id var/logic
# TODO: create iam_instance_profile var/logic
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
