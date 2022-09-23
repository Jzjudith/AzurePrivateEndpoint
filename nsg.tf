resource "azurerm_network_security_group" "main" {
  name                = "Server-NSG"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name


  security_rule {
    name                       = "Allow-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

security_rule {
    name                       = "Allow-http"
    priority                   = 112
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-MySql"
    priority                   = 115
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Sql"
  }
}
 
resource "azurerm_network_interface_security_group_association" "dbs" {
  network_interface_id      = azurerm_network_interface.dbs.id
  network_security_group_id = azurerm_network_security_group.main.id
}



