/***************************************************************************************
* Create a Unity Catalog metastore (and the AWS bucket & IAM role if required)
****************************************************************************************/


locals {
  
  prefix   = "databricks-sumit-prakash"
}

resource "databricks_metastore" "unity" {
  provider      = databricks.workspace
  name          = "unity-metastore-sumit"
  storage_root = "s3://${aws_s3_bucket.metastore.id}/metastore"
  owner         = var.unity_admin_groups
  force_destroy = true
}

resource "databricks_metastore_data_access" "default_dac" {
  provider     = databricks.workspace
  metastore_id = databricks_metastore.unity.id
  name         = "default_dac"
  is_default   = true
  aws_iam_role {
    role_arn = var.unity_metastore_iam
    /*
    // Uncomment this if creating ARN and not pre-creating the ARN. For ARN Creation refer uc-PassRole.tf
    // role_arn = aws_iam_role.metastore_data_access.arn
    */
  }
}

resource "databricks_metastore_assignment" "default_metastore" {
  provider      = databricks.workspace
  workspace_id         = var.databricks_workspace_ids
  metastore_id         = databricks_metastore.unity.id
  default_catalog_name = "hive_metastore"
}

resource "databricks_catalog" "catalog" {
  provider      = databricks.workspace
  metastore_id = databricks_metastore.unity.id
  name         = var.catalog_name
  comment      = "this catalog is managed by terraform"
  properties = {
    purpose = "testing"
  }
  depends_on = [databricks_metastore_assignment.default_metastore]
}

resource "databricks_schema" "this" {
  
  provider      = databricks.workspace
  catalog_name = databricks_catalog.catalog.id
  name         = var.schema_name

  comment = "This database is managed by terraform"
  properties = {
    kind = "various"
  }
}



