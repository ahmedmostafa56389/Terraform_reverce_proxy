variable "vpc_id" {
  type = string 
  description = " vpc ID "
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "pub_sub" {
  type = list
  description = "list of     subnets"
}

variable "pub_cidr" {
  type =list
  description = "list of public cidrs"
}

variable "priv_sub" {
  type = list
  description = "list of private subnets"
}

variable "priv_cidrs" {
  type = list
  description = "list of private cidrs"
}

variable "AZs" {
  type = list 
  description = "list of used availability zones"
}
