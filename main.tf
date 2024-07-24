provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "network" {
  source     = "./modules/network"
  pub_sub = var.public_subnets_names
  pub_cidr = var.public_cidrs
  priv_sub = var.private_subnets_names
  priv_cidrs = var.private_cidrs
  vpc_cidr   = var.vpc_cidr
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
