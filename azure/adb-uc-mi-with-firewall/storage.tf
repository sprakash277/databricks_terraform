provider "azuread" {
}

 data "azuread_service_principal" "sumit-sp-uc" {
  display_name = "sumit-sp-uc"
}

 data "azuread_service_principal" "common-sa-sp" {
   display_name = "common-sa-sp"
}
 data "azuread_service_principal" "common-sa-sp2" {
   display_name = "common-sa-sp2"
}

resource "azurerm_storage_account" "svcendpointaccess" {
  name                = "svcendpointaccess${random_string.naming.result}"
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  tags                     = local.tags
}


resource "azurerm_storage_account" "pvtendpointaccess" {
  name                = "pvtendpointaccess${random_string.naming.result}"
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  tags                     = local.tags


  network_rules {
    default_action             = "Deny"
  }
  
}


/*
resource "azurerm_storage_account_network_rules" "svcendpointaccess" {

  storage_account_id         = azurerm_storage_account.svcendpointaccess.id
  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.public.id,azurerm_subnet.private.id]
  depends_on = [azurerm_subnet.public]
 # bypass                     = ["Metrics"]
}
*/

// Create Resource with Metastore  - Firewall enabled. We need to attach the vnet network created as part of deployment



/*
resource "azurerm_storage_account_network_rules" "accessfirewallenabledmetastore_nwrk" {

  depends_on = [azurerm_subnet.public,azurerm_subnet.private]
  storage_account_id = var.metastore_storage_name
  virtual_network_subnet_ids = [azurerm_subnet.public.id,azurerm_subnet.private.id]
  default_action             = "Deny"
  
}
*/



resource "azurerm_storage_account" "diagnosticlog" {
  name                = "diagnosticlog${random_string.naming.result}"
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  tags                     = local.tags
  
}



resource "azurerm_role_assignment" "sumit-sp-uc" {
  scope                = azurerm_storage_account.svcendpointaccess.id
  role_definition_name = "Storage Blob Data Contributor"
  #principal_id   = "7128e532-395f-4565-ba44-c6d04cf231ab"
  principal_id         = data.azuread_service_principal.sumit-sp-uc.object_id
}


resource "azurerm_role_assignment" "common-sa-sp" {
  scope                = azurerm_storage_account.svcendpointaccess.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.common-sa-sp.object_id
}

resource "azurerm_role_assignment" "common-sa-sp2" {
  scope                = azurerm_storage_account.svcendpointaccess.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.common-sa-sp2.object_id
}

resource "azurerm_role_assignment" "pvtendpointaccess_common-sa-sp" {
  scope                = azurerm_storage_account.pvtendpointaccess.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.common-sa-sp.object_id
}

resource "azurerm_role_assignment" "pvtendpointaccess_common-sa-sp2" {
  scope                = azurerm_storage_account.pvtendpointaccess.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.sumit-sp-uc.object_id
}