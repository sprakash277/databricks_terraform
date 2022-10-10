variable "groups" {
description = "Map of AAD group names into object describing workspace & Databricks SQL access permissions"
  type = map(object({
    workspace_access = bool
    allow_sql_analytics_access = bool
    allow_cluster_create = bool
    allow_instance_pool_create = bool
    admin = bool  # if this group for Databricks admins
  }))
  default    = {
    "Cosmin Lita MS Teams Invites" = {
    workspace_access = true
    allow_sql_analytics_access = true
    allow_cluster_create = true
    allow_instance_pool_create = true
    admin = false  # if this group for Databricks admins
    },
     "Analysts" = {
    workspace_access = true
    allow_sql_analytics_access = true
    allow_cluster_create = true
    allow_instance_pool_create = true
    admin = true  # if this group for Databricks admins
    }
  }
}

variable "host" {
  type = string
  default = "CHANGE ME"
}

variable "token" {
  type = string
  default = "CHANGE ME-3"
}

variable "tenant_id" {
  type = string
  default = "CHANGE ME"
}

variable "user_id" {
  type = string
}
