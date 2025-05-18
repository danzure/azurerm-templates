# create a resource group for network infrastructure
resource "azurerm_resource_group" "hubspoke_rg" {
  name     = "rg-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  location = var.location
  tags     = var.tags
}

# create the hub virtual network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"
  location            = azurerm_resource_group.hubspoke_rg.location
  resource_group_name = azurerm_resource_group.hubspoke_rg.name
  address_space       = var.hub_vnet_address_space
  tags                = var.tags
}

# create the hub virtual subnet
resource "azurerm_subnet" "hub_snet" {
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name  = azurerm_resource_group.hubspoke_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.hub_subnet_address_prefix]
}

# create the Azure Bastion subnet
resource "azurerm_subnet" "bastion_snet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hubspoke_rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.bas_address_prefix]
}

# create the public IP for the Bastion host
resource "azurerm_public_ip" "bas_pip" {
  name                = "pip-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"
  location            = azurerm_resource_group.hubspoke_rg.location
  resource_group_name = azurerm_resource_group.hubspoke_rg.name
  allocation_method   = "Static"
  sku                 = "Standard" #[Standard]
  sku_tier            = "Regional" #[Regional, Global]
  tags                = var.tags

  depends_on = [azurerm_subnet.bastion_snet] # Ensure subnet for Bastion host is created first
}

# create a bastion host
resource "azurerm_bastion_host" "bas_host" {
  name                = "bas-${format("%s", local.generate_env_name.envrionment)}-${var.hub_workload}-${format("%s", local.generate_loc_name.location)}-001"
  location            = azurerm_resource_group.hubspoke_rg.location
  resource_group_name = azurerm_resource_group.hubspoke_rg.name
  sku                 = "Basic" # [Basic, Standard, Premium]

  ip_configuration {
    name                 = "bas-ip-config"
    subnet_id            = azurerm_subnet.bastion_snet.id
    public_ip_address_id = azurerm_public_ip.bas_pip.id
  }

  copy_paste_enabled        = true    # [enabled by default, upgrade to standard to turn this on/off]
  ip_connect_enabled        = false   # [upgrade to standard before enabling this setting]
  kerberos_enabled          = false   # [upgrade to standard before enabling this setting]
  shareable_link_enabled    = false   # [upgrade to standard before enabling this setting]
  session_recording_enabled = false   # [upgrade to standard sku to use this feature]
  tags                      = var.tags
}

# create one VNET for each number specified in the spoke count variable
resource "azurerm_virtual_network" "spoke_vnet" {
  count               = var.spoke_count
  name                = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.spoke_workload}-${format("%s", local.generate_loc_name.location)}-${format("%03d", count.index + 1)}"
  location            = azurerm_resource_group.hubspoke_rg.location
  resource_group_name = azurerm_resource_group.hubspoke_rg.name
  address_space       = [cidrsubnet(var.spoke_vnet_address_space_cidr, var.spoke_vnet_new_bits, count.index)]
  tags                = var.tags

  depends_on = [azurerm_virtual_network.hub_vnet] # Explicit dependency if spoke relies on hub being up first (e.g., for peering)
}