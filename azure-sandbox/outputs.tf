output "app_vnet_address_space" {
  description = "Outputs the address space for the application vnet"
  value       = azurerm_virtual_network.app_vnet.address_space
}

output "app_vnet_name" {
  description = "Outputs the name of the app vnet"
  value       = azurerm_virtual_network.app_vnet.name
}

output "bastion_ip" {
  description = "Outputs the IP address of the bastion host"
  value       = azurerm_bastion_host.bastion_host.ip_configuration
}

output "firewall_pip" {
  description = "Outputs the public IP of the firewall"
  value       = azurerm_public_ip.fw_pip.ip_address
}

output "resource_group_name" {
  description = "Outputs the name of the resource group"
  value       = azurerm_resource_group.sandbox_rg.name
}

output "shared_vnet_address_space" {
  description = "Outputs the address space for the shared vnet"
  value       = azurerm_virtual_network.shared_vnet.address_space
}

output "shared_vnet_name" {
  description = "Outputs the name of the shared vnet"
  value       = azurerm_virtual_network.shared_vnet.name
}

output "storage_account_name" {
  description = "Outputs the name of the storage account"
  value       = azurerm_storage_account.sandbox_sa.name 
}

output "tenant_id" {
  description = "Outputs the value of the tenant id"
  value       = data.azurerm_client_config.current.tenant_id
}

output "vhub_id" {
  description = "Outputs the id of the virtual hub"
  value       = azurerm_virtual_hub.sandbox_vhub.id
}

output "vwan_id" {
  description = "Outputs the id of the virtual wan"
  value       = azurerm_virtual_wan.sandbox_vwan.id
}