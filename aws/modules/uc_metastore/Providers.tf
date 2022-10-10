terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
     aws = {
      source  = "hashicorp/aws"
      
    }
    
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

// initialize provider in "MWS" mode, to add users at account-level
provider "databricks" {
  alias      = "mws"
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  username   = var.databricks_account_username
  password   = var.databricks_account_password
}


// initialize provider at workspace level, to create UC resources
// authentication using one of the described approaches at
// https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "workspace"
  host     = var.databricks_workspace_host
  username = var.databricks_account_username
  password = var.databricks_account_password
}