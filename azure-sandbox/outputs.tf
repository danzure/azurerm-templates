output "rg_name_output" {
  description = "outputs the name of the resource group"
  value = azurerm_resource_group.sandbox_rg.name
}

output "vnet_address_space" {
  description = "outputs the address space for the virtual network"
  value = azurerm_virtual_network.shared_vnet.address_space
}

output "tenant_id_ouput" {
  description = "outputs the value of the tenant id"
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id_ouput" {
  description = "outputs the value of the current subscription id"
  value = data.azurerm_client_config.current.subscription_id
}