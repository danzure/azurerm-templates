# deploy the azure firewall resource group
resource "azurerm_resource_group" "firewall_rg" {
  name = format("rg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  location = var.location
  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_virtual_network" "firewall_vnet" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  location = var.location

  name = format("vnet-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )

  address_space = var.vnet_address_space
  tags = var.tags
  depends_on = [ azurerm_resource_group.firewall_rg ]
}

resource "azurerm_subnet" "name" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  virtual_network_name = azurerm_virtual_network.firewall_vnet.name

  name = format("snet-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_prefixes = var.fw_subnet_range
  depends_on = [ azurerm_resource_group.firewall_rg, azurerm_virtual_network.firewall_vnet ]
}

resource "azurerm_firewall" "firewall" {
  resource_group_name = azurerm_resource_group.firewall_rg.name
  location = azurerm_resource_group.firewall_rg.location

  name = format("fw-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  sku_name = ""
  sku_tier = ""

  tags = var.tags
}