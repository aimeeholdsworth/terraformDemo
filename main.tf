provider "aws"{
    region = "eu-west-2"
    access_key = var.access_key
    secret_key = var.secret_key
}

module "vpc" {
    source = "./vpc"

    nat_gate_id = module.subnets.nat_gate_id
}

module "subnets" {
    source = "./subnets"
    vpc_id = module.vpc.vpc_id
    route_id = module.vpc.route_id
    route_id_private = module.vpc.route_id_private
    sec_group_id    = module.vpc.sec_group_id
    security_id = module.vpc.security_id
    internet_gate = module.vpc.internet_gate
    net_private_ips = ["10.0.1.50"]

}

module "ec2" {
    source          = "./ec2"

    net_id          = module.subnets.net_id
    ami_id          = "ami-096cb92bb3580c759"
    instance_type   = "t2.medium"
    av_zone         = "eu-west-2a"
    key_name        = "firstkey"
    subnet_group_name = module.subnets.subnet_group_name
    sec_group_id_sql  = module.vpc.sec_group_id_sql
    
}