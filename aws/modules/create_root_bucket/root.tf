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

resource "aws_s3_bucket" "root_storage_bucket" {
  #bucket = "${local.prefix}-rootbucket"
  bucket = "${var.prefix}-rootbucket"
  #acl    = "private"
#  versioning {
#    enabled = false
#  }
  force_destroy = true

  tags = var.tags

}

resource "aws_s3_bucket_public_access_block" "root_storage_bucket" {
  bucket             = aws_s3_bucket.root_storage_bucket.id
  ignore_public_acls = true
  depends_on         = [aws_s3_bucket.root_storage_bucket]
}

data "databricks_aws_bucket_policy" "this" {
  bucket = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  policy = data.databricks_aws_bucket_policy.this.json
}

resource "databricks_mws_storage_configurations" "this" {
  provider                   = databricks.mws
  account_id                 = var.databricks_account_id
  bucket_name                = aws_s3_bucket.root_storage_bucket.bucket
  #storage_configuration_name = "${local.prefix}-storage"
   storage_configuration_name = "${var.prefix}-storage"
}
