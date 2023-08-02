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

# data "aws_subnet" "default" {
#   for_each = toset(data.aws_subnets.default.ids)
#   id       = each.value
# }

# resource "aws_subnet" "example" {
#   vpc_id     = aws_default_vpc.default.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "example_subnet"
#   }
# }






# IAM role
resource "aws_iam_role" "role" {
  name = "elasticbeanstalk-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect  = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM policy
resource "aws_iam_policy" "policy" {
  name        = "elasticbeanstalk-ec2-policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "BucketAccess",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::elasticbeanstalk-*",
                "arn:aws:s3:::elasticbeanstalk-*/*"
            ]
        },
        {
            "Sid": "XRayAccess",
            "Action": [
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets",
                "xray:GetSamplingStatisticSummaries"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "CloudWatchLogsAccess",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:*:*:log-group:/aws/elasticbeanstalk*"
            ]
        },
        {
            "Sid": "ElasticBeanstalkHealthAccess",
            "Action": [
                "elasticbeanstalk:PutInstanceStatistics"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:elasticbeanstalk:*:*:application/*",
                "arn:aws:elasticbeanstalk:*:*:environment/*"
            ]
        }
    ]
})
}

# IAM policy attachment
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

# IAM instance profile
resource "aws_iam_instance_profile" "profile" {
  name = "elasticbeanstalk-ec2-profile"
  role = aws_iam_role.role.name
}





resource "aws_elastic_beanstalk_environment" "nodejs_environment" {
  name                = "nodejsEnvironment"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.8.4 running Node.js 18"
  tier                = "WebServer"

setting {
  namespace = "aws:ec2:vpc"
  name      = "Subnets"
  value     = "subnet-02cea569fcb32f93e"
  
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

