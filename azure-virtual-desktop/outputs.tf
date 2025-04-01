# output the name of the resource group
output "rg_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.avd_rg.name
}

output "workload_name_output" {
  description = "Outputs the name of the application or worklaod specified"
  value       = var.workload
}

output "production_level_output" {
  description = "Outputs the production level for the deployment (prod/ dev)"
  value       = var.envrionment
}

output "location_output" {
  description = "Outputs the location the resources will be deployed too"
  value       = var.location
}

output "vdpool_name_output" {
  description = "Outputs the name of the avd host pool"
  value       = azurerm_virtual_desktop_host_pool.avd_vdpool.name
}

output "vdws_name_output" {
  description = "Outputs the name of the avd workspace"
  value       = azurerm_virtual_desktop_workspace.avd_vdws.name
}

output "vdag_name" {
  description = "Outputs the name of the virtual desktop application group (dag)"
  value       = azurerm_virtual_desktop_application_group.avd_dag.name
}

output "vnet_rg_name" {
  description = "Outputs the name of the resurce group containing the virtual network"
  value       = azurerm_resource_group.network_rg.name
}

output "vnet_address_space" {
  description = "Outputs the ip address range for the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "snet_address_prefix" {
  description = "Outputs the address space for the virtual subnet"
  value       = azurerm_subnet.avd_subnet.address_prefixes
}

output "ngw_ippre_name_output" {
  description = "value"
  value = azurerm_public_ip_prefix.ngw_ippre.name
}

output "ngw_pip_name_output" {
  description = "value"
  value = azurerm_public_ip.ngw_pip.name
}

output "ngw_name_output" {
  description = "value"
  value = azurerm_nat_gateway.avd_ngw.name
}

output "rd_host_count" {
  description = "Outputs the number of remote desktop hosts to be deployed"
  value       = var.rdsh_count
}

output "profile_storage_share" {
  description = "Outputs the of the storage account for FSLogix profiles"
  value       = azurerm_storage_account.sa_fslogix.name
}

output "app_storage_share" {
  description = "Outputs the name of the storage account for MSIXAPP"
  value       = azurerm_storage_account.sa_msixapp.name
}

output "resource_tags" {
  description = "Outputs the tags that will be applied to the avd resources"
  value       = var.avd_tags
}

output "workspace_friendly_name" {
  description = "Outputs the friendly name for the avd workspace"
  value       = azurerm_virtual_desktop_workspace.avd_vdws.friendly_name
}