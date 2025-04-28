# create a resource group for network infrastructure
resource "azurerm_resource_group" "infra_rg" {
  name = format("rg-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  location = var.location
  tags     = var.tags
}

# create the azure virtual network
resource "azurerm_virtual_network" "infra_vnet" {
  resource_group_name = azurerm_resource_group.infra_rg.name
  location            = azurerm_resource_group.infra_rg.location
  tags                = var.tags

  name = format("vnet-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  address_space = ["10.10.0.0/22"]

  depends_on    = [azurerm_resource_group.infra_rg]
}

# create a general data subnet 
resource "azurerm_subnet" "data_snet" {
  name = format("snet-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  resource_group_name  = azurerm_resource_group.infra_rg.name
  virtual_network_name = azurerm_virtual_network.infra_vnet.name
  address_prefixes     = ["10.10.0.0/24"]

  depends_on           = [azurerm_resource_group.infra_rg, azurerm_virtual_network.infra_vnet]
}

# create a network security group 
resource "azurerm_network_security_group" "infra_nsg" {
  resource_group_name = azurerm_resource_group.infra_rg.name
  location            = azurerm_resource_group.infra_rg.location
  tags                = var.tags

  name = format("nsg-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  depends_on = [ azurerm_resource_group.infra_rg, azurerm_subnet.data_snet ]
}

# associate the Network Security Group to the azure data subnet
resource "azurerm_subnet_network_security_group_association" "nsg_attach" {
  subnet_id                 = azurerm_subnet.data_snet.id
  network_security_group_id = azurerm_network_security_group.infra_nsg.id

  depends_on = [ azurerm_subnet.data_snet ]
}

# create public ip address (PIP) for the nat gateway
resource "azurerm_public_ip" "ngw_pip" {
  resource_group_name = azurerm_resource_group.infra_rg.name
  location            = azurerm_resource_group.infra_rg.location

  name = format("pip-%s-ngw-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.location
  )
  allocation_method = "Static"
  sku               = "Standard"
  tags              = var.tags

  depends_on = [ azurerm_resource_group.infra_rg ]
}

# create a NAT Gateway for outbound internet connectivity
resource "azurerm_nat_gateway" "infra_ngw" {
  resource_group_name = azurerm_resource_group.infra_rg.name
  location            = azurerm_resource_group.infra_rg.location
  tags                = var.tags

  name = format("ngw-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  idle_timeout_in_minutes = 10
}

# associate the public ip address to the the NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "ngw_pip_attach" {
  nat_gateway_id       = azurerm_nat_gateway.infra_ngw.id
  public_ip_address_id = azurerm_public_ip.ngw_pip.id
}

# associate the NAT Gateway 
resource "azurerm_subnet_nat_gateway_association" "snet_ngw_attach" {
  nat_gateway_id = azurerm_nat_gateway.infra_ngw.id
  subnet_id = azurerm_subnet.data_snet.id
}

data "azurerm_public_ip" "pip_address" {
  name = azurerm_public_ip.ngw_pip.name
  resource_group_name = azurerm_resource_group.infra_rg.name
}