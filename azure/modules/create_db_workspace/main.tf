
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

data "azurerm_client_config" "current" {
}

data "external" "me" {
  program = ["az", "account", "show", "--query", "user"]
}

locals {
  prefix = var.adb_workspace_name
  tags = {
    Environment = "Demo"
    Owner       = lookup(data.external.me.result, "name")
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${local.prefix}-rg"
  location = var.region
  tags     = local.tags
}

resource "azurerm_databricks_workspace" "this" {
  name                        = "${local.prefix}-workspace"
  resource_group_name         =  var.resource_group_name
  location                    = azurerm_resource_group.this.location
  sku                         = "premium"
  managed_resource_group_name = "${local.prefix}-workspace-rg"
  tags                        = local.tags
  custom_parameters {
    virtual_network_id          = "/subscriptions/3f2e4d32-8e8d-46d6-82bc-5bb8d962328b/resourceGroups/sumit_rg_adb/providers/Microsoft.Network/virtualNetworks/sumit_vnet1"
    private_subnet_name         = "sumit_subnetA"
    private_subnet_network_security_group_association_id                = "/subscriptions/3f2e4d32-8e8d-46d6-82bc-5bb8d962328b/resourceGroups/sumit_rg_adb/providers/Microsoft.Network/networkSecurityGroups/databricksnsgg5rmteqjdsz6s"
    public_subnet_name          = "default"
    public_subnet_network_security_group_association_id         = "/subscriptions/3f2e4d32-8e8d-46d6-82bc-5bb8d962328b/resourceGroups/sumit_rg_adb/providers/Microsoft.Network/networkSecurityGroups/databricksnsgg5rmteqjdsz6s"
  }
}



