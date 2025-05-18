output "bas_address_prefix" {
  description = "The name of the Azure Bastion subnet"
  value       = azurerm_subnet.bastion_snet.address_prefixes
}

output "hub_vnet_id" {
  description = "The unique identifier (ID) of the Hub Virtual Network."
  value       = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_name" {
  description = "The name of the Hub Virtual Network."
  value       = azurerm_virtual_network.hub_vnet.name
}

output "hub_vnet_address_space" { # Corrected typo from addess_space
  description = "The list of address spaces assigned to the Hub Virtual Network."
  value       = azurerm_virtual_network.hub_vnet.address_space
}

output "hub_snet" {
  description = "The list of address prefixes assigned to the Hub subnet."
  value       = azurerm_subnet.hub_snet.address_prefixes
}

output "rg_name" {
  description = "The name of the Azure Resource Group created for the hub and spoke deployment."
  value       = azurerm_resource_group.hubspoke_rg.name
}

output "rg_id" {
  description = "The unique identifier (ID) of the Azure Resource Group created for the hub and spoke deployment."
  value       = azurerm_resource_group.hubspoke_rg.id
}

output "hub_peering_names" {
  description = "A list of names for the virtual network peerings established from the Hub VNet to the Spoke VNets."
  value       = azurerm_virtual_network_peering.hub_peerto_spoke[*].name
}

output "spoke_vnet_name" {
  description = "A list of names for each Spoke Virtual Network deployed."
  value       = azurerm_virtual_network.spoke_vnet[*].name
}

output "spoke_vnet_id" {
  description = "A list of unique identifiers (IDs) for each Spoke Virtual Network deployed."
  value       = azurerm_virtual_network.spoke_vnet[*].id
}

output "spoke_vnet_address_space" {
  description = "A list where each item contains the list of address spaces for a corresponding Spoke Virtual Network deployed."
  value       = azurerm_virtual_network.spoke_vnet[*].address_space
}