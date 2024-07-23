variable "sec_group_a" {
  type = string
  description = "apache security group id"
}

variable "sec_group_n" {
  type = string
  description = "nginx security group id"
} 


variable "pub_subnet" {
  type = list
  description = "puplic subnets ID"
}

variable  "priv_subnet" {
  type  = list
  description = "private subnet ID"
}

variable "apache_ami"  {
  type = string
  description  = "apache ec2 image"
}

variable "priv_lb_dns" {
  type = string
  description = "loadbalancer dns"
}




