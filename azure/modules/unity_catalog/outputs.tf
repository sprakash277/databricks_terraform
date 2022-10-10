
output "sp_directory_id" {
  value = var.tenant_id
}


output "storage_path" {
  value = format("abfss://%s@%s.dfs.core.windows.net/",
    azurerm_storage_account.unity_catalog.name,
    azurerm_storage_container.unity_catalog.name
  )
}
