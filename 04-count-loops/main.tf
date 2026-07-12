resource "aws_instance" "roboshop" {
  count                  = 10
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop[count.index].id, aws_security_group.common.id,]
  tags                   = { 
    Name = "${var.project}-${var.environment}-${var.instances[count.index]}" # interpolation
    
  } 
}

resource "aws_security_group" "roboshop" {
  count       = 10
  name        = "${var.project}-${var.environment}-${var.instances[count.index]}"
  description = "Allow TLS inbound traffic and all outbound traffic"
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocal
    cidr_blocks = var.cidr
  }

  tags = { Name = "${var.project}-${var.environment}-${var.instances[count.index]}"}

   # first it creates SG and then modify instance SG
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common-1"
  description = "Allow TLS inbound traffic and all outbound traffic"
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocal
    cidr_blocks = var.cidr
  }

  tags = { Name = "${var.project}-${var.environment}-common"}
  
  
  lifecycle {
    create_before_destroy = true
  }
}