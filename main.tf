resource "aws_security_group" "bastion" {
  name        = "${var.stack_name}_${var.bastion_name}"
  description = "proxy host for whatever pattern I decide to use..."
  vpc_id      = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allows"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
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
    Name  = var.bastion_name
    Stack = var.stack_name
  }
}
