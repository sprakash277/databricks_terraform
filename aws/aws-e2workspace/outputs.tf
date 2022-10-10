output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}


output "mws_workspace_id" {
  value = databricks_mws_workspaces.this.workspace_id
}
