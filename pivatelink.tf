# private dns zone
resource "azurerm_private_dns_zone" "main" {
  name                = var.private_dns_zone
  resource_group_name = var.resource_group
}

# private dns zone-virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = "dns-vnet-link"
  resource_group_name   = var.resource_group
  private_dns_zone_name = var.private_dns_zone
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = true
  depends_on            = [azurerm_private_dns_zone.main]

}

# private endpoint
resource "azurerm_private_endpoint" "main" {
  name                = "dev-lab-pe"
  resource_group_name = var.resource_group
  location            = var.location
  subnet_id           = azurerm_subnet.main.id

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
