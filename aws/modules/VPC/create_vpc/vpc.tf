terraform {
  required_providers {
    
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.4.8"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.68.0"
    }
  }
}
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}


locals {
  prefix = "fs-cf-sumit-${random_string.naming.result}"
  databricks_account_username = var.databricks_account_username
  databricks_account_password  =  var.databricks_account_password
  databricks_account_id = var.databricks_account_id
  cross_account_role_arn =  var.cross_account_role_arn
} 

data "aws_availability_zones" "available" {}

provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name = var.prefix
  cidr = var.cidr_block
  azs  = data.aws_availability_zones.available.names
  tags = var.tags

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  create_igw           = true

  public_subnets = [cidrsubnet(var.cidr_block, 3, 0)]
  private_subnets = [cidrsubnet(var.cidr_block, 3, 1),
  cidrsubnet(var.cidr_block, 3, 2)]

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal TCP and UDP"
    self        = true
  }]
}

resource "databricks_mws_networks" "this" {
  provider           = databricks.mws
  account_id         = local.databricks_account_id
  #network_name       = "${local.prefix}-network"
  network_name       = "${var.prefix}-network"
  security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
}
