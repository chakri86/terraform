resource "aws_instance" "terraform_demo" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_terraform.id] # list
    # labels, metadata, info, etc
    tags = {
        Name = "terraform-demo-1"
        Project = "roboshop"
        Environment = "dev"
    }

    provisioner "local-exec" {
      command = "echo  ${self.private_ip} > inventory.ini"
    }

    provisioner "local-exec" {
      command = "echo instance created"
    }

    provisioner "local-exec" {
      when    = destroy
      command = "echo instance is going to be destroyed"
    }

    provisioner "local-exec" {
      when    = destroy
      command = "echo > inventory.ini"
    }

    connection {
      type        = "ssh"
      user        = "ec2-user"
      password = "DevOps321"
      host        = self.public_ip
    }


    /* provisioner "remote-exec" {
      inline = [
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx"
      ]
    }

    provisioner "remote-exec" {
      when = destroy
      inline = [
        "sudo systemctl stop nginx"
      ]
    } */

    provisioner "file" {
      source      = "script.sh"
      destination = "/tmp/script.sh"
    }
}

# It creates in default VPC
resource "aws_security_group" "allow_terraform" {
  name        = "allow_terraform_provisioners"
  description = "Allow TLS inbound traffic and all outbound traffic"

  # outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_terraform"
    Project = "roboshop"
    Environment = "dev"
  }
}