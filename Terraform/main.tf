# terraform {
#   required_version = ">= 0.13"

#   backend "s3" {
#     bucket = "your-s3-bucket-name"
#     key    = "terraform.tfstate"
#     region = "us-west-2"
#   }
# }

provider "aws" {
  region = "us-east-1"
}


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
  # variable1 = "value1"
}

# module "database" {
#   source = "./modules/database"
#   # variable1 = "value1"
# }
