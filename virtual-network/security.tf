# create a default rdp rule for the network security group
resource "azurerm_network_security_rule" "nsg_rdp_rule" {
  resource_group_name         = azurerm_resource_group.infra_rg.name
  network_security_group_name = azurerm_network_security_group.infra_nsg.name

  name                       = "AllowHttpsInbound"
  priority                   = "500"
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}