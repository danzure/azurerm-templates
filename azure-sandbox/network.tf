# create the 'shared' azure virtual network for azure bastion, azure firewall resources
resource "azurerm_virtual_network" "shared_vnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

  name = format("vnet-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_space = [ "10.10.0.0/22" ]
}

# create the shared azure subnet 
resource "azurerm_subnet" "adds_snet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  name = format("snet-%s-adds-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  address_prefixes = [ "10.10.0.0/24" ]

  depends_on = [ azurerm_virtual_network.shared_vnet ]
}

# create the azure bastion subnet
resource "azurerm_subnet" "bastion_subnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  name = "AzureBastionSubnet" 
  address_prefixes = [ "10.10.1.0/26" ]

  depends_on = [ azurerm_virtual_network.shared_vnet ]
}

# create a public ip resource for the bastion host
resource "azurerm_public_ip" "bastion_pip" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

  name = format("pip-%s-bastion-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  sku  = "Standard" # [Basic, Standard]
  allocation_method = "Static"
  idle_timeout_in_minutes = 10

  depends_on = [ azurerm_virtual_network.shared_vnet ]
}

# create the azure bastion host resource 
resource "azurerm_bastion_host" "bastion_host" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags
  
  name = format("bas-%s-%s-%s-001",
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
  
  depends_on = [ azurerm_subnet.bastion_subnet, azurerm_public_ip.bastion_pip ]
}

# create the public ip resource for azure firewall
resource "azurerm_public_ip" "fw_pip" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

  name = format("pip-%s-firewall-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  sku  = "Standard" # [Basic, Standard] 
  allocation_method = "Static"
  idle_timeout_in_minutes = 10

  depends_on = [ azurerm_virtual_network.shared_vnet ]
}

# create the AzureFirewallSubnet
resource "azurerm_subnet" "firewall_subnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.shared_vnet.name
  name = "AzureFirewallSubnet"
  address_prefixes = [ "10.10.1.64/26" ]

  depends_on = [ azurerm_virtual_network.shared_vnet ]
}

# create the azure firewall resource
resource "azurerm_firewall" "firewall" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

  name = format("fw-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  sku_name = "AZFW_Hub" # [AZFW_VNet, AZFW_Hub]
  sku_tier = "Standard" # [Basic, Standard, Premium]
  
  ip_configuration {
    name = "ip-configuration"
    subnet_id = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

# create the 'application' azure virtual network
resource "azurerm_virtual_network" "app_vnet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location

  name = format("vnet-%s-%s-%s-002",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  address_space = [ "10.20.0.0/22" ]
  tags = var.tags

  depends_on = [ azurerm_resource_group.sandbox_rg ]
}

# create the application subnet
resource "azurerm_subnet" "app_snet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name

  name = format("snet-%s-application-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  address_prefixes = [ "10.20.0.0/24" ]

  depends_on = [ azurerm_virtual_network.app_vnet ]
}

# create the database subnet
resource "azurerm_subnet" "db_snet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name

  name = format("snet-%s-database-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  address_prefixes = [ "10.20.1.0/24" ]

  depends_on = [ azurerm_virtual_network.app_vnet ]
}

# create the database subnet
resource "azurerm_subnet" "privatelink_snet" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name

  name = format("snet-%s-privatelink-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.location
  )
  address_prefixes = [ "10.20.2.0/24" ]

  depends_on = [ azurerm_virtual_network.app_vnet ]
}