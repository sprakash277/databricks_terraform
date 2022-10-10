variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_account_id" {}
variable "unity_admin_groups" {}
variable "unity_metastore_bucket" {}
variable "unity_metastore_iam" {}
variable "Owner" {}

variable "cross_account_role_arn" {}


variable "aws_profile" {}

variable "tags" {
  default = {
    Owner = "sumit.prakash@databricks.com"
  }
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
}

variable "prefix" {
  type = string
}

variable "catalog_name" {
  description = "catalog_name"
  type        = string
}

variable "schema_name" {
  description = "schema_namen"
  type        = string
}
