terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">=0.5.1"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.83.0"
    }
  }
}


provider "databricks" {

  #alias = "pat_resource_for_metastore_creation"

  host = var.databricks_workspace_host
  token = var.pat_token
}

resource "databricks_metastore" "this" {

  name = var.metastore_name
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",var.uc_storage_account_name,var.uc_container_name)
  owner = var.metastore_owner
  // forcefully remove that auto-created
  // catalog we have no access to
  force_destroy = true
}

/*
resource "databricks_metastore_data_access" "first" {

  metastore_id = databricks_metastore.this.id
  name         = "the-keys"
  azure_service_principal {
    directory_id   = var.tenant_id
    application_id = var.application_id
    client_secret  = var.client_secret
  }

  // added this argument here, as we have
  // a cyclic dependency between entities and
  // it's the best way around it
  is_default = true
}
*/
// For Azure using managed identity as credential (Private Preview)

resource "databricks_metastore_data_access" "this" {

  metastore_id = databricks_metastore.this.id
  name         = "mi_dac"
  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }
  is_default = true
}
/*
data databricks_metastore_data_access_id "unity_metastore" {

  metastore_id = var.reuse_rg ? databricks_metastore_data_access.this.metastore_id : var.metastore.id
}
*/
resource "databricks_metastore_assignment" "this" {

  for_each             = toset(var.workspace_ids)
  workspace_id         = each.key
  metastore_id         = databricks_metastore.this.id
  default_catalog_name = "hive_metastore"

}

resource "databricks_catalog" "catalog" {

  metastore_id = databricks_metastore.this.id
  name         = var.catalog_name
  comment      = "This catalog is managed by terraform"
  properties = {
    purpose = "TF Deployed"
  }
  depends_on = [databricks_metastore_assignment.this]

}

resource "databricks_schema" "things" {

  catalog_name = databricks_catalog.catalog.id
  name         = var.schema_name

  comment = "This database is managed by terraform"
  properties = {
    kind = "various"
  }
}
