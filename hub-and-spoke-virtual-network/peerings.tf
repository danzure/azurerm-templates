# create a network peer from hub to each virtual network spoke
resource "azurerm_virtual_network_peering" "hub_peerto_spoke" {
  name                      = "hub-peerto-spoke-${format("%03d", count.index + 1)}"
  resource_group_name       = azurerm_resource_group.hubspoke_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet[count.index].id
  count                     = var.spoke_count

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

# create a network peer from hub to each virtual network spoke
resource "azurerm_virtual_network_peering" "spoke_peerto_hub" {
  name                      = "spoke-${format("%03d", count.index + 1)}-peerto-hub"
  resource_group_name       = azurerm_resource_group.hubspoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet[count.index].name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  count                     = var.spoke_count

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}