terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source = "../../modules/network"

  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_az           = var.public_az
  private_az          = var.private_az
}

module "compute" {
  source = "../../modules/compute"

  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
}

output "alb_dns" {
  value = module.compute.alb_dns_name
}
