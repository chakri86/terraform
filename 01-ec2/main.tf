resource "aws_instance" "terraform_demo"{
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_terraform.id ]
    tags = { 
        Name = "terraform_demo-1"
        project = "rpboshop"
        environrment = "dev"
    }
}

resource "aws_security_group" "allow_terraform" {
  name        = "allow_terraform"
  description = "Allow TLS inbound traffic and all outbound traffic"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_terraform"
    project = "rpboshop"
    environrment = "dev"
  }
}