####################
#VPC VARS
####################
variable "region" {
  description = "The region to create resources."
  default     = "eu-west-2"
}

variable "namespace" {
  description = <<EOH
this is the differantiates different deployment on the same subscription, every cluster should have a different value
EOH
  default = "andre_hackathon"
}

variable "owner" {
description = "IAM user responsible for lifecycle of cloud resources used for training"
default = "andre"
}

variable "created-by" {
description = "Tag used to identify resources created programmatically by Terraform"
default = "Terraform"
}

variable "sleep-at-night" {
description = "Tag used by reaper to identify resources that can be shutdown at night"
default = true
}

variable "TTL" {
description = "Hours after which resource expires, used by reaper. Do not use any unit. -1 is infinite."
default = "240"
}

variable "vpc_cidr_block" {
description = "The top-level CIDR block for the VPC."
default = "10.1.0.0/16"
}

variable "cidr_blocks" {
description = "The CIDR blocks to create the workstations in."
default = ["10.1.1.0/24", "10.1.2.0/24"]
}

####################
#EC2 VARS
####################

data "http" "myipaddr" {
    url = "http://ipv4.icanhazip.com"
}

locals {
   host_access_ip = ["${chomp(data.http.myipaddr.body)}/32"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "instance_type_worker" {
description = "The type(size) of data servers (consul, nomad, etc)."
default = "m5.large"
}


variable "ssh_public_key" {
    description = "The contents of the SSH public key to use for connecting to the cluster."
    default = "~/.ssh/id_rsa.pub"
}