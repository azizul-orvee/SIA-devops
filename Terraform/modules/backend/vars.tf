variable "iam_role_name" {
  type = string
}

variable "elasticapp" {
  type = string
}
variable "beanstalkappenv" {
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