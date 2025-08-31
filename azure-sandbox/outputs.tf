output "app_vnet_address_space" {
  description = "The address space of the application virtual network."
  value       = azurerm_virtual_network.app_vnet.address_space
}

output "app_vnet_name" {
  description = "The name of the application virtual network."
  value       = azurerm_virtual_network.app_vnet.name
}

output "bastion_ip" {
  description = "The IP configuration of the Bastion host."
  value       = azurerm_bastion_host.bastion_host.ip_configuration
}

output "environment" {
  description = "The deployment environment (e.g., dev, test, prod)."
  value       = var.environment
}

output "firewall_pip" {
  description = "The public IP address of the Azure Firewall."
  value       = azurerm_public_ip.fw_pip.ip_address
}

output "location" {
  description = "The Azure region where resources are deployed."
  value       = var.location
}

output "resource_group_name" {
  description = "The name of the resource group containing the resources."
  value       = azurerm_resource_group.sandbox_rg.name
}

output "shared_vnet_address_space" {
  description = "The address space of the shared virtual network."
  value       = azurerm_virtual_network.shared_vnet.address_space
}

output "shared_vnet_name" {
  description = "The name of the shared virtual network."
  value       = azurerm_virtual_network.shared_vnet.name
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account."
  value       = azurerm_storage_account.sandbox_sa.name
}

output "tenant_id" {
  description = "The Azure Active Directory tenant ID."
  value       = data.azurerm_client_config.current.tenant_id
}

output "vhub_id" {
  description = "The resource ID of the Azure Virtual Hub."
  value       = azurerm_virtual_hub.sandbox_vhub.id
}

output "vwan_id" {
  description = "The resource ID of the Azure Virtual WAN."
  value       = azurerm_virtual_wan.sandbox_vwan.id
}