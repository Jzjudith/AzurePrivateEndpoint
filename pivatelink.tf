resource "azurerm_private_dns_zone" "main" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {
name                  = "dns-vnet-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.main.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = true
  depends_on            = [azurerm_private_dns_zone.main]
  
}

resource "azurerm_private_endpoint" "main" {
  name                = "dev-lab-pe"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.dbs.id

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.main.id]
  }

  private_service_connection {
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mysql_server.main.id
    name                           = "dev-lab-psc"
    subresource_names              = ["MySqlServer"]
  }
  depends_on = [azurerm_private_dns_zone_virtual_network_link.main]
}
