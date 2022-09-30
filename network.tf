# resource group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group
  location = var.location
}

# virtual network
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = ["10.0.0.0/16"]
  depends_on = [
    azurerm_resource_group.main
  ]
}

# subnet
resource "azurerm_subnet" "main" {
  name                                      = var.subnet
  resource_group_name                       = var.resource_group
  virtual_network_name                      = var.virtual_network
  address_prefixes                          = ["10.0.2.0/24"]
  private_endpoint_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.main
  ]
}

# public ip
resource "azurerm_public_ip" "main" {
  name                = "databasepip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "DevOps"
  }
  depends_on = [
    azurerm_resource_group.main
  ]
}

# network interface
resource "azurerm_network_interface" "main" {
  name                = "database-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id

  }
  depends_on = [
    azurerm_subnet.main
  ]
}





