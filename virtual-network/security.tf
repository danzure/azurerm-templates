# create rule for NSG to allow HTTPS traffic on port 80 inbound for web traffic
resource "azurerm_network_security_rule" "nsg_https80_inbound" {
  resource_group_name         = azurerm_resource_group.infra_rg.name
  network_security_group_name = azurerm_network_security_group.infra_nsg.name

  name                       = "AllowHttps80Inbound"
  priority                   = "500"
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

# create rule for NSG to allow HTTPS traffic on port 80 inbound for web traffic
resource "azurerm_network_security_rule" "nsg_https443_inbound" {
  resource_group_name         = azurerm_resource_group.infra_rg.name
  network_security_group_name = azurerm_network_security_group.infra_nsg.name

  name                       = "AllowHttps443Inbound"
  priority                   = "550"
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*" 
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}