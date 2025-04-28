output "rg_name_output" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.infra_rg.name
}

output "vnet_name_output" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.infra_vnet.name
}

output "snet_name_output" {
  description = "The name of the created subnet 1."
  value       = azurerm_subnet.data_snet.name
}

output "ngw_name_output"{
  description = "The name of the created NAT gateway."
  value       = azurerm_nat_gateway.infra_ngw.name
}

output "pip_address_output" {
  description = "Outputs the public ip address for the NAT Gateway"
  value = data.azurerm_public_ip.pip_address.ip_address
}