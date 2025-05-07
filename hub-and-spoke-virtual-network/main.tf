# create a resource group for network infrastructure
resource "azurerm_resource_group" "hub_spoke_rg" {
  name = format("rg-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location,
  )
  location = var.location
  tags     = var.tags
}

# ----- Hub VNET + SNET -----

resource "azurerm_virtual_network" "hub_vnet" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location = azurerm_resource_group.hub_spoke_rg.location
  address_space = var.hub_vnet_addess_space
  name = "vnet-hub-name"
  tags = var.tags
}

resource "azurerm_subnet" "hub_snet" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name 
  virtual_network_name = azurerm_virtual_network.hub_vnet.name 
  address_prefixes = [var.hub_subnet_address_prefix]
  name = "hub-snet-name"
}

# ----- Spoke networks

resource "azurerm_virtual_network" "spoke-vnet" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name 
  location = azurerm_resource_group.hub_spoke_rg.location

  # create one VNET for each number specified in the var.spoke_count
  name = format ("snet-d-infra-uks-${count.index + 1}")
  address_space = [cidrsubnet(var.spoke_vnet_address_space_cidr, var.spoke_vnet_new_bits, count.index)]
  count = var.spoke_count
  tags = var.tags
}