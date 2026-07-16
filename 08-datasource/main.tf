resource "aws_instance" "roboshop" {
  for_each = var.instances
  ami                    = data.aws_ami.joindevops.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop[each.key].id, aws_security_group.common.id,]
  tags                   = { 
    Name = "${var.project}-${var.environment}-${each.key}" # interpolation
    
  } 
}

resource "aws_security_group" "roboshop" {
  for_each = var.instances
  name        = "${var.project}-${var.environment}-${each.key}"
  description = "Allow TLS inbound traffic and all outbound traffic"
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocal
    cidr_blocks = var.cidr
  }

   dynamic "ingress" {
    for_each = var.ingress_rules
    content{
        from_port        = ingress.value.port
        to_port          = ingress.value.port
        protocol         = "tcp" # commonly addressed TCP protocol
        cidr_blocks      = ingress.value.cidr_blocks
    }
  }


  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-${var.environment}-${each.key}"}

   # first it creates SG and then modify instance SG
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common"
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