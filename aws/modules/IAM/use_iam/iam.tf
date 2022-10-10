
terraform {
  required_providers {
    
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.4.8"
    }
  }
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}
/*
locals {
  prefix = "fs-cf-sumit-${random_string.naming.result}"
}
*/
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

resource "databricks_mws_credentials" "this" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  role_arn           = var.cross_account_role_arn
  credentials_name = "${var.prefix}-creds"
  #credentials_name = "${local.prefix}-creds"
  
}