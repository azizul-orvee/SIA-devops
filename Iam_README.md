
# Create IAM user 
 
Configure the service role and EC2 instance profile that Elastic Beanstalk uses to manage your environment.




## Create IAM policy:

```bash
{
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
}
```


	
- Create IAM Role and add trusted entity: AWS Service: ec2
- Attach the policy with this role. 

#### Remember the role name as we will need to put it as a variable in terraform apply command
