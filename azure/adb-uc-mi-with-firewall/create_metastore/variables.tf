variable "databricks_workspace_host" {
  type    = string
}

variable "pat_token" {
  type    = string
}

variable "metastore_name" {
  type    = string
}

variable "metastore_owner" {
  type    = string
}

variable "catalog_name" {
  type    = string
}

variable "schema_name" {
  type    = string
}


variable "uc_storage_account_name" {
  type    = string
}
variable "workspace_ids" {
  type = list(any)
}

variable "uc_container_name" {
  type    = string
}

variable "access_connector_id" {
  type    = string
}

variable "location" {
  type    = string
}
