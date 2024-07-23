variable "a_ami" {
  type = string 
  default = "ami-04a81a99f5ec58529"
}

variable "av_zones" {
  type = list
  description = "availaball zones"
  default = ["us-east-1a" , "us-east-1b"]
}
