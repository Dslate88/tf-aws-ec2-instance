resource "aws_security_group" "default" {
  name   = "${var.stack_name}_${var.env}_sg"
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  # temp
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }
  # temp
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  tags = {
    Stack = var.stack_name,
    Env   = var.env
  }
}

resource "aws_instance" "bastion" {
  ami                     = var.ami
  disable_api_termination = var.disable_api_termination
  instance_type           = var.instance_type
  key_name                = var.key_name
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [aws_security_group.bastion.id]
  tags = {
    Name  = "bastion_${var.stack_name}_${var.env}"
    Stack = var.stack_name,
    Env   = var.env
  }
}
