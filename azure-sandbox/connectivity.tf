# deploy virtual wan
resource "azurerm_virtual_wan" "sandbox_vwan" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags

  name = format("vwan-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )

  depends_on = [azurerm_resource_group.sandbox_rg]
}

# deploy virtual hub to the virtual wan
resource "azurerm_virtual_hub" "sandbox_vhub" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  virtual_wan_id      = azurerm_virtual_wan.sandbox_vwan.id
  address_prefix      = "10.40.0.0/24"

  name = format("vhub-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
}

resource "azurerm_virtual_hub_connection" "vhub_shared_peer" {
  virtual_hub_id            = azurerm_virtual_hub.sandbox_vhub.id
  remote_virtual_network_id = azurerm_virtual_network.shared_vnet.id
  name                      = "vhub-peerTo-shared-vnet"
}

resource "azurerm_virtual_hub_connection" "vhub_app_peer" {
  virtual_hub_id            = azurerm_virtual_hub.sandbox_vhub.id
  remote_virtual_network_id = azurerm_virtual_network.app_vnet.id
  name                      = "vhub-peerTo-app-vnet"
}

# peer shared virtual network to application virtual network
resource "azurerm_virtual_network_peering" "shared_vnet_peer" {
  resource_group_name       = azurerm_resource_group.sandbox_rg.name
  virtual_network_name      = azurerm_virtual_network.shared_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.app_vnet.id
  name                      = "shared-vnet-peerTo-app-vnet"

  depends_on = [azurerm_virtual_network.shared_vnet, azurerm_virtual_network.app_vnet]

  lifecycle {
    create_before_destroy = false
  }
}

# peer application virtual network to shared virtual network
resource "azurerm_virtual_network_peering" "app_vnet_peer" {
  resource_group_name       = azurerm_resource_group.sandbox_rg.name
  virtual_network_name      = azurerm_virtual_network.app_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.shared_vnet.id
  name                      = "app-vnet-peerTo-shared-vnet"

  depends_on = [azurerm_virtual_network.shared_vnet, azurerm_virtual_network.app_vnet]

  lifecycle {
    create_before_destroy = false
  }
}

# create files private endpoint for storage account

# create blob private endpoint for stroage account

# create & mysql private endpoint