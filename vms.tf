resource "azurerm_linux_virtual_machine" "dbs" {
  name                            = "databaseVM"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = "devlab"
  admin_password                  = "Password123"
  network_interface_ids           = [azurerm_network_interface.dbs.id, ]
  disable_password_authentication = false
  user_data                       = filebase64("${path.module}/scripts/mysqlclient.sh")

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

