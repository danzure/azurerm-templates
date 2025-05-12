# create a resource group for network infrastructure
resource "azurerm_resource_group" "hub_spoke_rg" {
  name     = "rg-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  location = var.location
  tags     = var.tags
}

# cresate the hub virtual network 
resource "azurerm_virtual_network" "hub_vnet" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_resource_group.hub_spoke_rg.location
  address_space       = var.hub_vnet_addess_space
  name                = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"
  tags                = var.tags

  depends_on = [azurerm_resource_group.hub_spoke_rg]
}

# create the hub virtual subnet
resource "azurerm_subnet" "hub_snet" {
  resource_group_name  = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.hub_subnet_address_prefix]
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"

  depends_on = [azurerm_resource_group.hub_spoke_rg, azurerm_virtual_network.hub_vnet]
}

# ------- Dynamic Spoke Virtual Network ------- #

# create one VNET for each number specified in the spoke count varible
resource "azurerm_virtual_network" "spoke_vnet" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_resource_group.hub_spoke_rg.location

  name          = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.spoke_workload}-${format("%s", local.generate_loc_name.location)}-${format("%03d", count.index + 1)}"
  address_space = [cidrsubnet(var.spoke_vnet_address_space_cidr, var.spoke_vnet_new_bits, count.index)]
  count         = var.spoke_count
  tags          = var.tags
}

# create a network peer from hub to each virtual network spoke
resource "azurerm_virtual_network_peering" "hub_peerto_spoke" {
  resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet[count.index].id
  name                      = "hub-peerto-spoke${format("%03d", count.index + 1)}"
  count                     = var.spoke_count

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}

# create a network peer from hub to each virtual network spoke
resource "azurerm_virtual_network_peering" "spoke_peerto_hub" {
  resource_group_name       = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet[count.index].name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  name                      = "spoke${format("%03d", count.index + 1)}-peerto-hub"
  count                     = var.spoke_count

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false

  depends_on = [azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet]
}