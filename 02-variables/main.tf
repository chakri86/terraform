resource "aws_instance" "terraform_demo" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_terraform_var.id]
  tags                   = var.ec2-tags
}

resource "aws_security_group" "allow_terraform_var" {
  name        = "allow_terraform_var"
  description = "Allow TLS inbound traffic and all outbound traffic"
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocal
    cidr_blocks = var.cidr
  }

  tags = var.sec_tags
}