provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "network" {
  source     = "./modules/network"
  pub_sub = ["public_1" , "public_2" ]
  pub_cidr = ["10.0.2.0/24" , "10.0.3.0/24"]
  priv_sub = ["private_1" , "private_2"]
  priv_cidrs = ["10.0.0.0/24" , "10.0.1.0/24"]
  vpc_cidr   = "10.0.0.0/16"
  vpc_id     = module.network.vpc_id
  AZs        = var.av_zones
}

module "ec2" {
  source    = "./modules/ec2"
  sec_group_a = module.network.sec_group_a
  sec_group_n = module.network.sec_group_n
  pub_subnet = module.network.pub_id
  priv_subnet = module.network.priv_id
  apache_ami = var.a_ami
  priv_lb_dns = module.loadbalancer.priv_lb_dns    
}

module "loadbalancer" {
  source  = "./modules/loadbalancer"
  apache_ids = module.ec2.apache_ids
  nginx_ids = module.ec2.nginx_ids
  sec_group_a = module.network.sec_group_a
  sec_group_n = module.network.sec_group_n
  pub_subnet = module.network.pub_id
  priv_subnet = module.network.priv_id
  vpc_id      = module.network.vpc_id
}
