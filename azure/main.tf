/*

Set the below variables before running the script
export $GITHUB_TOKEN="CHANGE ME"
export $AZURE_TENANT_ID="CHANGE ME"
export $AZURE_SUBSCRIPTION_ID="CHANGE ME"

export TF_VAR_tenant_id=$AZURE_TENANT_ID
export TF_VAR_subscription_id=$AZURE_SUBSCRIPTION_ID
export TF_VAR_github_token=$GITHUB_TOKEN





*/


terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.92.0"
    }
    databricks = {
      source = "databrickslabs/databricks"
      version = "~>0.4.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~>2.15.0"
    }

  }
}

# Add the dependency to the child moudule workspace creation.
data "databricks_current_user" "me" {
  depends_on = [module.create_db_workspace]
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}


 provider "azuread" {
   tenant_id = var.tenant_id
}
provider "databricks" {

  host  = module.create_db_workspace.databricks_host
  token = module.create_pat_token.databricks_token
}  

provider "github" {
  #organization = "wahlnetwork"
  token        = var.github_token
}

module "create_db_workspace" {
  source = "./modules/create_db_workspace"
}


module "create_pat_token" {
  source = "./modules/create_pat_token"
  host = module.create_db_workspace.databricks_host

}


module "scim_AAD" {
  source = "./modules/scim_AAD"
  #host = module.create_db_workspace.databricks_host
  #token = module.create_pat_token.databricks_token
  # To add lazy Authentication, Call the  ata.databricks_current_user which has dependency to the child moudule workspace creation.
  user_id = data.databricks_current_user.me.id
  providers = {

    databricks = databricks
    azuread = azuread
  }

}


module "unity_catalog" {
  source = "./modules/unity_catalog"
  workspace_ids = module.create_db_workspace.workspace_id
  databricks_workspace_host = module.create_db_workspace.databricks_host
  #host = module.create_db_workspace.databricks_host
  #token = module.create_pat_token.databricks_token
  # To add lazy Authentication, Call the  ata.databricks_current_user which has dependency to the child moudule workspace creation.
  //user_id = data.databricks_current_user.me.id
  user_id = data.databricks_current_user.me.id
  providers = {

    databricks = databricks
  }

}


module "sync_repos" {
  source = "./modules/sync_repos"
  providers = {

    databricks = databricks
    github = github
  }

}
