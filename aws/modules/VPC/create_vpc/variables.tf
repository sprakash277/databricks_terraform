
variable "databricks_account_id" {}
variable "databricks_account_username" {}
variable "databricks_account_password" {}


variable "cross_account_role_arn" {}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "tags" {
  default = {}
}

variable "prefix" {}





