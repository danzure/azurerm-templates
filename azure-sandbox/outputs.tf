output "app_vnet_name_output" {
  description = "outputs the name of the app vnet"
  value       = azurerm_virtual_network.app_vnet.name
}

output "app_vnet_address_space" {
  description = "outputs the address space for the application vnet"
  value       = azurerm_virtual_network.app_vnet.address_space
}

output "bastion_ip_output" {
  description = "outputs the ip address of the bastion host"
  value       = azurerm_bastion_host.bastion_host.ip_configuration
}

output "firewall_pip" {
  description = "outputs the public ip of the firewall"
  value       = azurerm_public_ip.fw_pip.ip_address
}

output "rg_name_output" {
  description = "outputs the name of the resource group"
  value       = azurerm_resource_group.sandbox_rg.name
}

output "shared_vnet_name_output" {
  description = "outputs the name of the shared vnet"
  value       = azurerm_virtual_network.shared_vnet.name
}

output "shared_vnet_address_space" {
  description = "outputs the address space for the shared vnet"
  value       = azurerm_virtual_network.shared_vnet.address_space
}

output "tenant_id_output" {
  description = "outputs the value of the tenant id"
  value       = data.azurerm_client_config.current.tenant_id
}

output "vwan_id_output" {
  description = "outputs the id of the virtual wan"
  value       = azurerm_virtual_wan.sandbox_vwan.id
}

output "vhub_id_output" {
  description = "outputs the id of the virtual hub"
  value       = azurerm_virtual_hub.sandbox_vhub.id
}