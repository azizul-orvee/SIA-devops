provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "nodejs-app-${random_pet.petname.id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  force_destroy = true
}

resource "random_pet" "petname" {}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "Backend.zip"
  source = "/home/redis/Codes/SIA/Backend.zip"  # replace with the path to your local zip file
  acl    = "private"
}

resource "aws_elastic_beanstalk_application" "app" {
  name        = "nodejs-app"
  description = "My Node.js application"
}

resource "aws_default_vpc" "default" {}

data "aws_subnets" "default" {
    filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
     }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}


resource "aws_elastic_beanstalk_environment" "nodejs_environment" {
  name                = "nodejsEnvironment"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.8.4 running Node.js 18"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_default_vpc.default.id  # replace with your VPC ID
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", data.aws_subnets.default.ids)  //replace with your actual subnet IDs
    }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", data.aws_subnets.default.ids)  //replace with your actual subnet IDs
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "4"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "nodejs-app-version"
  application = aws_elastic_beanstalk_application.app.name

  // Bucket name where your zipped code is stored
  bucket = aws_s3_bucket.bucket.bucket

  // The name of the zipped code file
  key = aws_s3_bucket_object.object.key

  depends_on = [aws_s3_bucket_object.object]
}

