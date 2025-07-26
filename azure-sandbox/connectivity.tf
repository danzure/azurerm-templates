# deploy virtual wan
resource "azurerm_virtual_wan" "sandbox_vwan" {
  name                = "vwan-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags

  depends_on = [azurerm_resource_group.sandbox_rg]
}

# deploy virtual hub to the virtual wan
resource "azurerm_virtual_hub" "sandbox_vhub" {
  name                = "vhub-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  virtual_wan_id      = azurerm_virtual_wan.sandbox_vwan.id
  address_prefix      = "10.40.0.0/24"
}

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

resource "azurerm_private_link_service" "priv_link_serv" {
  name                = "sandbox-privatelink"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  nat_ip_configuration {
    name      = "ip-configuration"
    primary   = true
    subnet_id = azurerm_subnet.privatelink_snet.id
  }
  load_balancer_frontend_ip_configuration_ids = []
}

# create files private endpoint for storage account
resource "azurerm_private_endpoint" "sa_files_endpoint" {
  name                = "files-endpoint"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    private_connection_resource_id = azurerm_private_link_service.priv_link_serv.id
    name                           = "storage-privateendpointconnection"
    is_manual_connection           = false
  }
}

# create blob private endpoint for stroage account
resource "azurerm_private_endpoint" "sa_blob_endpoint" {
  name                = "blob-endpoint"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    private_connection_resource_id = azurerm_private_link_service.priv_link_serv.id
    name                           = "blog-privateendpoint"
    is_manual_connection           = false
  }
  depends_on = [ azurerm_private_link_service.priv_link_serv ]
}

# create mysql private endpoint
resource "azurerm_private_endpoint" "mysql_endpoint" {
  name                = "mysql-endpoint"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  subnet_id           = azurerm_subnet.privatelink_snet.id

  private_service_connection {
    private_connection_resource_id = azurerm_private_link_service.priv_link_serv.id
    name                           = "msql-privateendpoint"
    is_manual_connection           = false
  }
  depends_on = [ azurerm_private_link_service.priv_link_serv ]
}