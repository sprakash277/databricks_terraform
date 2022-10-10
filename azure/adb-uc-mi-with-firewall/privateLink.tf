resource "azurerm_private_dns_zone" "example" {
  name                = "example.privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

}

resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = "vnet_link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.this.id
  depends_on = [
    azurerm_virtual_network.this
  ]
  #registration_enabled = true
}

resource "azurerm_private_endpoint" "example" {
  name                = "spoke-vnet-endpoint"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.plsubnet.id


  private_service_connection {
    name                              = "example-privateserviceconnection"
    private_connection_resource_id    = azurerm_storage_account.pvtendpointaccess.id
    is_manual_connection              = false
    subresource_names                 =  ["dfs"]
  }

  
}

resource "azurerm_private_dns_a_record" "dns_a" {
  name                = azurerm_storage_account.pvtendpointaccess.name
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.example.private_service_connection.0.private_ip_address]

}



// PL setup for the UC metastore

resource "azurerm_private_dns_zone" "metastore" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

}

resource "azurerm_private_dns_zone_virtual_network_link" "metastore_network_link" {
  name                  = "metastore_vnet_link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.metastore.name
  virtual_network_id    = azurerm_virtual_network.this.id
   depends_on = [
    azurerm_virtual_network.this
  ]
  #registration_enabled = true
}


resource "azurerm_private_endpoint" "metastore" {
  name                = "metastore-vnet-endpoint"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.plsubnet.id


  private_service_connection {
    name                              = "metastore-privateserviceconnection"
    private_connection_resource_id    = var.metastore_storage_id
    is_manual_connection              = false
    subresource_names                 =  ["dfs"]
  }
}
resource "azurerm_private_dns_a_record" "dns_b" {

  name                = var.metastore_storage_name
  zone_name           = azurerm_private_dns_zone.metastore.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 20
  records             = [azurerm_private_endpoint.metastore.private_service_connection.0.private_ip_address]

}

