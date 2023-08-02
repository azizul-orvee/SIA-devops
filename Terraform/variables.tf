variable "elasticapp" {
  default = "ScopicDevOpsApp"
}
variable "beanstalkappenv" {
  default = "ScopicDevOpsEnv"
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  type = string
}
 
variable "vpc_id" {
  type  = string
  default = "vpc-07365c98fd5f6fbec"
}
variable "public_subnets" {
  type  = list(string)
  default = ["subnet-02cea569fcb32f93e", "subnet-0a30f70a3715dddec"]
}
variable "elb_public_subnets" {
  type  = list(string)
  default = ["subnet-041d20ec9feb666dd", "subnet-057aa400623fdf7e3"]
}