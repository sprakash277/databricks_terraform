terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "~>0.4.0"
    }
  }
}

provider "databricks" {
  host = "https://adb-6470595692372502.2.azuredatabricks.net/?o=6470595692372502"
}

resource "databricks_group" "this" {
  display_name = "terraform_group1"
  allow_cluster_create = true
  allow_instance_pool_create = true
}

resource "databricks_user" "this" {
    user_name = "pardeep.kumar@databricks.com"
}

resource "databricks_group_member" "vip_member" {
    group_id = databricks_group.this.id
    member_id = databricks_user.this.id
}
