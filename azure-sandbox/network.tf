# create a virtual network for bastion & firewall resources
resource "azurerm_virtual_network" "shared_vnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location

  name = format("vnet-%s-%s-%s-${var.vnet_instance01}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_space = [ "10.1.0.0/23" ]
  tags = var.tags
}

# create the AzureBastionsubnet
resource "azurerm_subnet" "bastion_subnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  name = "AzureBastionSubnet"
  address_prefixes = [ "10.1.0.0/26" ]
}

# create the AzureFirewallSubnet
resource "azurerm_subnet" "firewall_subnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  name = "AzureFirewallSubnet"
  address_prefixes = [ "10.1.1.0/26" ]
}

# create a public ip address for bastion host
resource "azurerm_public_ip" "bastion_pip" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  name = "pip-d-bastion-host"
  sku  = "Standard"
  allocation_method = "Static"
  idle_timeout_in_minutes = 10

  tags = var.tags
}

# create the azure publip ip address for azure firewall
resource "azurerm_public_ip" "firewall_pip" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location

  name = "pip-d-firewall-host"
  sku  = "Standard"
  allocation_method = "Static"
  idle_timeout_in_minutes = 10

  tags = var.tags
}

# create the azure bastion host
resource "azurerm_bastion_host" "bastion_host" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  
  name = format("bas-%s-%s-%s-${var.vnet_instance01}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  ip_configuration {
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
    subnet_id = azurerm_subnet.bastion_subnet.id
    name = "bas-ip-configuration"
  }
  sku = "Basic" # [Basic, Standard, Premium]

  copy_paste_enabled = true # [enabled by default, upgrade to standard to turn this on/off]
  ip_connect_enabled = false # [upgrade to standard before enabling this setting]
  kerberos_enabled = false # [upgrade to standard before enabling this setting]
  shareable_link_enabled = false # [upgrade to standard before enabling this setting]
  session_recording_enabled = false # [upgrade to standard sku to use this feature]

  tags = var.tags
  
  depends_on = [ azurerm_subnet.bastion_subnet ]
}

# create the azure firewall