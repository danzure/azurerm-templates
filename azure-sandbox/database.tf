resource "azurerm_mssql_server" "mssql_server" {
  name                         = "mssql-server"
  resource_group_name          = azurerm_resource_group.sandbox_rg.name
  location                     = azurerm_resource_group.sandbox_rg.location
  version                      = "12.0"
  administrator_login          = "mssql-admin"
  administrator_login_password = "ChangeMe123"
}

resource "azurerm_mssql_database" "mssql_db" {
  name         = "example-db"
  server_id    = azurerm_mssql_server.mssql_server.id
}