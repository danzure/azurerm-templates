output "rsv_name_output" {
  description = "Outputs the name of the recovery services vault(s) to be deployed"
  value = azurerm_recovery_services_vault.rsv.*.name
}

output "location_output" {
  description = "Outputs the location the resources will be deployed too"
  value = var.location
}

output "workload_output" {
  description = "Outputs the name of the application or worklaod specified"
  value = var.workload
}

output "envrionment_output" {
  description = "Outputs the production level for the deployment (prod/ dev)"
  value = var.envrionment
}

output "storage_type_output" {
  description = "Outputs the level of redundancy to be applied to the recovery service vault(s)"
  value = var.rsv_storage_mode
}

output "immutability_output" {
  description = "Outputs if the immutability is enabled or disabled"
  value = var.rsv_immutability
}

output "cross_region_restore_output" {
  description = "Outputs if cross region restore option is enabled or disabled"
  value = azurerm_recovery_services_vault.rsv.*.cross_region_restore_enabled
}