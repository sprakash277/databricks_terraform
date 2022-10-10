variable "rg_name" {
  description = "Enter your resource group name"
  type        = string
  default = "sumit_rg_adb"
}

variable "location" {
  description = "Enter your location, i.e. West US or East US"
  type        = string
  default = "East US"
}

variable "reuse_rg" {
  description = "Reuse resource group, do not create a new resource group (enter true/false)"
  type        = bool
  default = "true"
}

variable "tenant_id" {
  description = "Enter your tenant id from Azure Portal"
  type        = string
}

variable "subscription_id" {
  description = "Enter your subscription id from Azure Portal"
  type        = string
}

variable "prefix" {
  description = "Enter a prefix to prepend to any created resources"
  type        = string
  default = "sumit"
}

variable "metastore_name" {
  description = "Enter the name of the metastore, it can be scoped by environment or LOB i.e. dev/prod/sales/engr"
  type        = string
  default = "sumit_dev_uc"
}

variable "metastore_owner" {
  description = "Enter the name of the metastore owner, this must be a valid email account or group name in Azure Active Directory"
  type        = string
  default = "sumit.prakash@databricks.com"
}

variable "catalog_name" {
  description = "Enter the name of a default catalog to create"
  type        = string
  default = "sumit_uc_dev"
}

variable "schema_name" {
  description = "Enter the name of a default schema to create"
  type        = string
  default = "sumit_uc_dev"
}

variable "workspace_ids" {
  description = <<EOT
  List of Databricks workspace ids to be enabled with Unity Catalog
  Enter with square brackets and double quotes
  e.g. ["111111111", "222222222"]  
  EOT
  type        = string
}

variable "tags" {
  description = "Enter a dictionary of tags to be added to any resources created"
  default     = {}
  type        = map(any)
}

variable "databricks_workspace_host" {
  description = "Databricks workspace url"
  type        = string
}



variable "application_id" {
  description = "SP ID"
  type        = string
}

variable "client_secret" {
  description = "SP Secret"
  type        = string
}

variable "application_object_id" {
  description = "SP Object ID"
  type        = string
}

variable "user_id" {
  type = string
}

