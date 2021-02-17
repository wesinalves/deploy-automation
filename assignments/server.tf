##############################
# Setup Terraform Assignment #
##############################

# Instructions:
# 1. Modify the Terraform so the "ami" and "instance_type" is set using a variable.
# 2. Modify the Terraform so the tags are set using a local value.
# 3. Add a default tag called "Environment" and set to the current workspace.

##########################
# Main (Terraform Setup) #
##########################

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.54.0"
}

#############
# Variables #
#############

variable "server_name" {
  default = "HelloWorldServer"
}

variable "ami" {
  default = "ami-0323c3dd2da7fb37d"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "workspace" {
  default = "current"
}

locals {
  server_name = var.server_name
  env_name    = var.workspace
}


##########
# Server #
##########

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = local.server_name
    Environment = local.env_name
  }
}
