provider "aws" {
  region  = "us-east-1"
  version = "~> 2.54.0"
}

data "aws_region" "current" {}
