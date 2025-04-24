output "rg_name_output" {
  description = "outputs the name of the resource group"
  value = azurerm_resource_group.sandbox_rg.name
}


output "shared_vnet_name_output" {
  description = "outputs the name of the shared vnet"
  value = azurerm_virtual_network.shared_vnet.name
}

output "app_vnet_name_output" {
  description = "outputs the name of the app vnet"
  value = azurerm_virtual_network.app_vnet.name
}

output "shared_vnet_address_space" {
  description = "outputs the address space for the shared vnet"
  value = azurerm_virtual_network.shared_vnet.address_space
}

output "app_vnet_address_space" {
  description = "outputs the address space for the application vnet"
  value = azurerm_virtual_network.app_vnet.address_space
}

output "tenant_id_ouput" {
  description = "outputs the value of the tenant id"
  value = data.azurerm_client_config.current.tenant_id
}

output "fw_pip_output" {
  description = "outputs the public ip of the firewall"
  value = azurerm_public_ip.fw_pip.ip_address
}

output "bastion_ip_output" {
  description = "outputs the ip address of the bastion host"
  value = azurerm_bastion_host.bastion_host.ip_configuration
}

output "tags_output" {
  description = "outputs the tags to be applied to resources"
  value = var.tags
}

output "location_output" {
  description = "outputs the deployment location"
  value = var.location
}