output "rg_name_output" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.hub_spoke_rg.name
}

output "vnet_hub_name_output" {
  description = "The name of the created resource group."
  value       = azurerm_virtual_network.hub_vnet.name
}

output "resource_group_id" {
  description = "ID of the created resource group."
  value       = azurerm_resource_group.hub_spoke_rg.id
}

output "hub_vnet_id" {
  description = "ID of the Hub VNet."
  value       = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_name" {
  description = "Name of the Hub VNet."
  value       = azurerm_virtual_network.hub_vnet.name
}

output "spoke_vnet_name" {
  description = "value"
  value       = azurerm_virtual_network.spoke_vnet[*].name
}

output "spoke_vnet_id" {
  description = "value"
  value       = azurerm_virtual_network.spoke_vnet[*].id
}

output "spoke_vnet_address_space" {
  description = "value"
  value       = azurerm_virtual_network.spoke_vnet[*].address_space
}