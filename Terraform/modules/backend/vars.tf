variable "elasticapp" {
  default = "DevOpsSIA"
}
variable "beanstalkappenv" {
  default = "DevOpsEnv"
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  type = string
}
 
variable "vpc_id" {
  type  = string
}
variable "public_subnets" {
  type  = list(string)
}
variable "elb_public_subnets" {
  type  = list(string)
}