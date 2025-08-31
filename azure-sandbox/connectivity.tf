resource "azurerm_virtual_hub_connection" "vhub_shared_peer" {
  name                      = "vhub-peerTo-shared-vnet"
  virtual_hub_id            = azurerm_virtual_hub.sandbox_vhub.id
  remote_virtual_network_id = azurerm_virtual_network.shared_vnet.id
}

resource "azurerm_virtual_hub_connection" "vhub_app_peer" {
  name                      = "vhub-peerTo-app-vnet"
  virtual_hub_id            = azurerm_virtual_hub.sandbox_vhub.id
  remote_virtual_network_id = azurerm_virtual_network.app_vnet.id
}

# peer shared virtual network to application virtual network
resource "azurerm_virtual_network_peering" "shared_vnet_peer" {
  name                      = "shared-vnet-peerTo-app-vnet"
  resource_group_name       = azurerm_resource_group.sandbox_rg.name
  virtual_network_name      = azurerm_virtual_network.shared_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.app_vnet.id

  depends_on = [azurerm_virtual_network.shared_vnet, azurerm_virtual_network.app_vnet]

  lifecycle {
    create_before_destroy = false
  }
}

# peer application virtual network to shared virtual network
resource "azurerm_virtual_network_peering" "app_vnet_peer" {
  name                      = "app-vnet-peerTo-shared-vnet"
  resource_group_name       = azurerm_resource_group.sandbox_rg.name
  virtual_network_name      = azurerm_virtual_network.app_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.shared_vnet.id

  depends_on = [azurerm_virtual_network.shared_vnet, azurerm_virtual_network.app_vnet]

  lifecycle {
    create_before_destroy = false
  }
}

#================= Private Endpoints =================#

# create files private endpoint for storage account
resource "azurerm_private_endpoint" "sa_files_endpoint" {
  name                = "files-private-endpoint"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    name                           = "pe-files-storage"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sandbox_sa.id
    subresource_names              = ["file"]
  }
}

# create blob private endpoint for stroage account
resource "azurerm_private_endpoint" "sa_blob_endpoint" {
  name                = "blob-private-endpoint"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    name                           = "pe-blob-storage"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sandbox_sa.id
    subresource_names              = ["blob"]
  }
}

# create mysql private endpoint
resource "azurerm_private_endpoint" "mysql_endpoint" {
  name                = "pe-mssql-db"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    name                           = "pe-mssql-db"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_database.mssql_db.id
  }
}