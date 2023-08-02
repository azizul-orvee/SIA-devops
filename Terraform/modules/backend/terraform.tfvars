vpc_id              = "vpc-07365c98fd5f6fbec"
Instance_type       = "t2.medium"
minsize             = 1
maxsize             = 2
public_subnets     = ["subnet-02cea569fcb32f93e", "subnet-0a30f70a3715dddec"] # Service Subnet
elb_public_subnets = ["subnet-041d20ec9feb666dd", "subnet-057aa400623fdf7e3"] # ELB Subnet
tier = "WebServer"
solution_stack_name= "64bit Amazon Linux 2 v3.2.0 running Python 3.8"