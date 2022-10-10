
resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "ucdiagnosticlogs"
  target_resource_id = azurerm_databricks_workspace.this.id  // The ID of an existing Resource on which to configure Diagnostic Settings. Changing this forces a new resource to be created.
  // Archive to Storage Account
  storage_account_id = azurerm_storage_account.diagnosticlog.id

  log {
    category = "unityCatalog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}