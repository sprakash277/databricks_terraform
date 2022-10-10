
variable "unity_metastore_bucket" {
  description = "UC metastore bucket"
  type        = string
}

variable "unity_metastore_iam" {
  description = "UC metastore IAM role"
  type        = string
}

variable "databricks_workspace_ids" {
  description = "List of Databricks workspace ids to be enabled with Unity Catalog, For Testing , using single workspace id"
  type        = string
}

variable "unity_admin_groups" {
  description = "Group to be set as owner of the metastore"
  type        = string
}
variable "databricks_account_id" {
  description = "Account Id that could be found in the bottom left corner of https://accounts.cloud.databricks.com/. Not your AWS account id, or Databricks workspace id"
  type        = string
}

variable "databricks_workspace_host" {
  description = "Databricks workspace url"
  type        = string
}

variable "databricks_account_username" {
  description = "Databricks account owner credentials"
  type        = string
}

variable "databricks_account_password" {
  description = "Databricks account owner credentials"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "UC Region"
  type        = string
}

variable "catalog_name" {
  description = "catalog_name"
  type        = string
}

variable "schema_name" {
  description = "schema_namen"
  type        = string
}

variable "aws_profile"{
  description = "AWS Profile"
  type        = string
}

