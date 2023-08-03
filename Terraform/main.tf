terraform {
  backend "s3" {
    bucket = "scopic-devops-tf-state-dbc3b6d55512d867"
    key    = "Scopic-devops-task/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  region = "us-east-1"
}

# module "iam" {
#   source = "./modules/iam"
#   # variable1 = "value1"
# }

# module "frontend" {
#   source = "./modules/frontend"
#   # variable1 = "value1"
# }


# module "auth" {
#   source = "./modules/auth"
#   # If your module accepts variables, they can be passed in here.
#   # variable1 = "value1"
#   # variable2 = "value2"
# }


module "backend" {
  source = "./modules/backend"
  iam_role_name       = var.iam_role_name
  elasticapp          = var.elasticapp
  beanstalkappenv     = var.beanstalkappenv
  vpc_id              = var.vpc_id
  public_subnets      = var.public_subnets
  elb_public_subnets  = var.elb_public_subnets # ELB Subnet
}


# module "database" {
#   source = "./modules/database"
#   # variable1 = "value1"
# }


