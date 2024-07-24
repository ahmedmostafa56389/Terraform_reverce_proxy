variable "public_subnets_names" {
  type = list
  description = "public subnets names"
  default = ["public_1" , "public_2" ]
}

variable "private_subnets_names" {
  type = list 
  description = "private subnets names"
  default = ["private_1" , "private_2"]
}

variable "public_cidrs" {
  type = list
  description = "public cidrs"
  default = ["10.0.2.0/24" , "10.0.3.0/24"]
}

variable "private_cidrs" {
  type = list 
  description = "private cidrs"
  default = ["10.0.0.0/24" , "10.0.1.0/24"]
}

variable "vpc_cidr" {
  type = string 
  description = "vpc cidr block"
  default = "10.0.0.0/16"
}


variable "a_ami" {
  type = string 
  default = "ami-04a81a99f5ec58529"
}

variable "av_zones" {
  type = list
  description = "availaball zones"
  default = ["us-east-1a" , "us-east-1b"]
}
