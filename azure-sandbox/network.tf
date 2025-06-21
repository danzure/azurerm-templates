# create the 'shared' azure virtual network for azure bastion, azure firewall resources
resource "azurerm_virtual_network" "shared_vnet" {
  name                = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  address_space       = var.shared_vnet_address_space
  tags                = var.tags
}

# create the shared azure subnet 
resource "azurerm_subnet" "adds_snet" {
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  address_prefixes     = var.adds_snet_address_prefix

  depends_on = [azurerm_virtual_network.shared_vnet]
}

# create the azure bastion subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  address_prefixes     = var.bas_snet_address_prefix

  depends_on = [azurerm_virtual_network.shared_vnet]
}

# create a public ip resource for the bastion host
resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags

  sku                     = "Standard" # [Basic, Standard]
  allocation_method       = "Static"
  idle_timeout_in_minutes = 10

  depends_on = [azurerm_virtual_network.shared_vnet]
}

# create the azure bastion host resource 
resource "azurerm_bastion_host" "bastion_host" {
  name                = "bas-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags


  ip_configuration {
    name                 = "bas-ip-configuration"
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
    subnet_id            = azurerm_subnet.bastion_subnet.id
  }

  sku                       = "Basic" # [Basic, Standard, Premium]
  copy_paste_enabled        = true    # [enabled by default, upgrade to standard to turn this on/off]
  ip_connect_enabled        = false   # [upgrade to standard before enabling this setting]
  kerberos_enabled          = false   # [upgrade to standard before enabling this setting]
  shareable_link_enabled    = false   # [upgrade to standard before enabling this setting]
  session_recording_enabled = false   # [upgrade to standard sku to use this feature]

  depends_on = [azurerm_subnet.bastion_subnet, azurerm_public_ip.bastion_pip]
}

# create the public ip resource for azure firewall
resource "azurerm_public_ip" "fw_pip" {
  name                = "pip-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-002"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags

  sku                     = "Standard" # [Basic, Standard] 
  allocation_method       = "Static"
  idle_timeout_in_minutes = 10

  depends_on = [azurerm_virtual_network.shared_vnet]
}

# create the AzureFirewallSubnet
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  address_prefixes     = var.firewall_snet_address_prefix

  depends_on = [azurerm_virtual_network.shared_vnet]
}

# create the azure firewall resource
resource "azurerm_firewall" "firewall" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags

  name     = "fw-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  sku_name = "AZFW_Hub" # [AZFW_VNet, AZFW_Hub]
  sku_tier = "Standard" # [Basic, Standard, Premium]

  ip_configuration {
    name                 = "ip-configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

# create the 'application' azure virtual network
resource "azurerm_virtual_network" "app_vnet" {
  name                = "vnet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-002"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  address_space       = var.app_vnet_address_space
  tags                = var.tags

  depends_on = [azurerm_resource_group.sandbox_rg]
}

# create the application subnet
resource "azurerm_subnet" "app_snet" {
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.app_snet_address_prefix

  depends_on = [azurerm_virtual_network.app_vnet]
}

# create the database subnet
resource "azurerm_subnet" "db_snet" {
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-002"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.db_snet_address_prefix

  depends_on = [azurerm_virtual_network.app_vnet]
}

# create the database subnet
resource "azurerm_subnet" "privatelink_snet" {
  name                 = "snet-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-003"
  resource_group_name  = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.privlink_snet_address_prefix

  depends_on = [azurerm_virtual_network.app_vnet]
}