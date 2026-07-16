variable "ami_id" {
  type        = string
  description = "rhel9 joindevops image"
  default     = "ami-0220d79f3f480ecf5"
}


variable "environment" {
  type        = string
  description = "environment"
  default     = "dev"
}


variable "instance_type" {
  type        = string
  description = "aws_instance"
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_type)
    error_message = "Environment must be t3.micro or t3.small."
  }
}

variable "ec2-tags" {
  type        = map(any)
  description = "ec2-tags"
  default = {
    Name         = "terraform_demo-1"
    project      = "rpboshop"
    environrment = "dev"
  }
}

variable "project"{
  default = "roboshop"
  type = string
}

variable "instances" {
  type = map
  default = {
    mongodb = {
      "instance_type" = "t3.micro"
    },
    redis = {
      "instance_type" = "t3.micro"
    },
    mysql = {
      "instance_type" = "t3.micro"
    },
    rabbitmq = {
      "instance_type" = "t3.micro"
    },
    catalogue = {
      "instance_type" = "t3.micro"
    },
    user = {
      "instance_type" = "t3.micro"
    },
    cart = {
      "instance_type" = "t3.micro"
    },
    shipping = {
      "instance_type" = "t3.micro"
    },
    payment = {
      "instance_type" = "t3.micro"
    },
    frontend = {
      "instance_type" = "t3.micro"
    }
  }
}


variable "sec_tags" {
  type        = map(any)
  description = "sec_group_tags"
  default = {
    Name         = "allow_terraform"
    project      = "rpboshop"
    environrment = "dev"
  }
}

variable "port" {
  type        = number
  description = "port number"
  default     = 0
}

variable "protocal" {
  type        = string
  description = "protocal"
  default     = "-1"
}

variable "cidr" {
  type        = list(any)
  description = "cidr_block"
  default     = ["0.0.0.0/0"]
}



variable "zone_id" {
  type        = string
  description = "zone-id"
  default     = "Z03373741NMWA7C0RATXM"
}

variable "domain_name" {
  type        = string
  description = "domain_name"
  default     = "avkc.online"
}

variable ingress_rules {
    default = {
        ssh = {
            port = 22
            cidr_blocks = ["0.0.0.0/0"]
        }
        http = {
            port = 80
            cidr_blocks = ["0.0.0.0/0"]
        }
        mysql = {
            port = 3306
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}