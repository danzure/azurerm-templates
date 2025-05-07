output "rg_name_output" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.hub_spoke_rg.name
}

output "vnet_name_output" {
  description = "The name of the created resource group."
  value       = azurerm_virtual_network.hub_vnet.name
}

