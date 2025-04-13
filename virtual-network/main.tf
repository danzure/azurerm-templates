# create a resource group for network infrastructure
resource "azurerm_resource_group" "network_rg" {
  name = format("rg-%s-%s-%s-${var.instance_number}",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  location = var.location
  tags     = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# create a virtual network (VNET) for network connectivity
resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location

  name = format("vnet-%s-%s-%s-${var.instance_number}",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  address_space = [var.vnet_address_space]
  tags          = var.tags
  depends_on    = [azurerm_resource_group.network_rg]
}

# create a virtual subnet (SNET) for the azure virtual desktop
resource "azurerm_subnet" "subnet" {
  name = format("snet-%s-%s-%s-001",
    local.generate_network_name.envrionment,
    local.generate_network_name.workload,
    local.generate_network_name.location
  )
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.snet_address_prefix]
  depends_on           = [azurerm_virtual_network.vnet]
}

# create a network security group (NSG) for the azure virtual desktop envrionment
resource "azurerm_network_security_group" "avd_nsg" {
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location

  name = format("nsg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )

  tags       = var.tags
  depends_on = [azurerm_resource_group.avd_rg, azurerm_subnet.avd_subnet]
}

# associate the Network Security Group (NSG) to the azure virtual desktop subnet
resource "azurerm_subnet_network_security_group_association" "nsg_attach" {
  subnet_id                 = azurerm_subnet.avd_subnet.id
  network_security_group_id = azurerm_network_security_group.avd_nsg.id

  depends_on = [azurerm_subnet.avd_subnet]
}

# create a default rdp rule for the network security group
resource "azurerm_network_security_rule" "nsg_rdp_rule" {
  network_security_group_name = azurerm_network_security_group.avd_nsg.name
  resource_group_name         = azurerm_resource_group.network_rg.name

  name                       = "AllowHttpsInbound"
  priority                   = "1000"
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"

  depends_on = [azurerm_network_security_group.avd_nsg]
}

# create public ip address (PIP) for the nat gateway
resource "azurerm_public_ip" "ngw_pip" {
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location

  name = format("pip-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  allocation_method = "Static"
  tags              = var.tags

  depends_on = [ azurerm_resource_group.avd_rg ]
}

# create ip pirefix for NAT Gateway
resource "azurerm_public_ip_prefix" "ngw_ippre" {
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location

  name = format("ippre%s%s%s${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  tags = var.tags
  depends_on = [ azurerm_resource_group.avd_rg ]
}

# create a NAT Gateway for outbound internet connectivity
resource "azurerm_nat_gateway" "avd_ngw" {
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location

  name = format("ngw-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  idle_timeout_in_minutes = 10
  tags                    = var.tags
}

# associate the public ip address to the the NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "ngw_pip_attach" {
  nat_gateway_id       = azurerm_nat_gateway.avd_ngw.id
  public_ip_address_id = azurerm_public_ip.ngw_pip.id
}

# associate the ip prefix to the NAT Gateway
resource "azurerm_nat_gateway_public_ip_prefix_association" "ippre_attach" {
  nat_gateway_id      = azurerm_nat_gateway.avd_ngw.id
  public_ip_prefix_id = azurerm_public_ip_prefix.ngw_ippre.id
}

# associate the NAT Gateway to the azure virtual desktop subnet
resource "azurerm_subnet_nat_gateway_association" "snet_ngw_attach" {
  nat_gateway_id = azurerm_nat_gateway.avd_ngw.id
  subnet_id      = azurerm_subnet.avd_subnet.id
}