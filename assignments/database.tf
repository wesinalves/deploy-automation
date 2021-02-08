#############################
# Database setup Assignment #
#############################

# Instructions:
#   Create a new database instance with the following specifications:
#     - Uses the MySQL engine (version 5.7)
#     - Runs as a `db.t2.micro` class
#     - Has the default username: `user`
#     - Has the default password: `password`
#     - Has 5GB of allocated storage
#     - Has the identifier `assignment-db`
#     - Set skip final snapshot to `true`

# Notes:
#  - Add all code within `aws_db_instance` below
#    (no need to create Variables, VPC, Subnets, Security Groups, etc...)
#  - Use official docs as a guide:
#    https://www.terraform.io/docs/providers/aws/r/db_instance.html


##########################
# Main (Terraform Setup) #
##########################

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.54.0"
}

############
# Database #
############

resource "aws_db_instance" "database" {
  ## --- INSERT CODE HERE --- ##
  
  allocated_storage         = 5
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = "mydb"
  username                  = "user"
  password                  = "password"
  parameter_group_name      = "default.mysql5.7"
  final_snapshot_identifier = "true"
  identifier                = "assignment-db"

}
