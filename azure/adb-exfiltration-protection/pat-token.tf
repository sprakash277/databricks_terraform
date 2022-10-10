provider "databricks" {
  alias = "created_workspace"

  host = "https://${azurerm_databricks_workspace.this.workspace_url}/"
}

resource "databricks_token" "pat" {
  
  comment  = "Terraform Provisioning"
  provider = databricks.created_workspace
  // 100 day token
  lifetime_seconds = 8640000
}
