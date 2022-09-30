# mysql server
resource "azurerm_mysql_server" "main" {
  name                              = "devscvsqlsvr"
  resource_group_name               = var.resource_group
  location                          = var.location
  version                           = "8.0"
  administrator_login               = "devlabr"
  administrator_login_password      = "Password123"
  sku_name                          = "GP_Gen5_2"
  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = {
    environment = "Devops"
  }
  depends_on = [
    azurerm_resource_group.main
  ]
}


# mysql database
resource "azurerm_mysql_database" "main" {
  name                = "devsqldb"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.main.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on = [
    azurerm_mysql_server.main
  ]
}


