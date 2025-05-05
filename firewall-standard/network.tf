resource "azurerm_virtual_network" "virtual_network" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  location = azurerm_resource_group.firewall_rg.name 
  tags = var.tags

  name = format("vnet-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "data_subnet" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name

  name = format("snet-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_prefixes = var.data_subnet_range
}

resource "azurerm_subnet" "firewall_subnet" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name

  name = "AzureFirewallSubnet"
  address_prefixes = var.firewall_subnet_range
}

