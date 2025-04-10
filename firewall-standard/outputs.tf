output "rg_name_output" {
  description = "Outputs the name of the resource group"
  value = azurerm_resource_group.resource_group.name
}

output "vnet_address_space_output" {
  description = "Outputs the address space for the VNET"
  value = azurerm_virtual_network.virtual_network.address_space
}

output "data_subnet_range_output" {
  description = "Outputs the data subnet range"
  value = azurerm_subnet.data_subnet.address_prefixes 
}