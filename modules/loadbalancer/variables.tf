variable "apache_ids" {
  type = list
  description = " the apache EC2 IDs "
}

variable "nginx_ids" {
  type = list
  description = " the nginx EC2 IDs "
}

variable "sec_group_a" {
  type = string
  description = " apache security group "
}

variable "sec_group_n" {
  type = string 
  description = "nginx security group"
}

variable "pub_subnet" {
  type = list 
  description = "public subnets IDs"
}

variable "priv_subnet" {
  type = list 
  description = "private subnets IDs"
}

variable "vpc_id" {
  type = string
  description = "vpc ID"
}

