output "rg_ids" {
  description = "A list of IDs for the created resource groups."
  value       = azurerm_resource_group.resource_group[*].id
}

output "rg_locations" {
  description = "A list of locations for the created resource groups."
  value       = azurerm_resource_group.resource_group[*].location
}

output "rg_name" {
  description = "A list of names for the created resource groups."
  value       = azurerm_resource_group.resource_group[*].name
}

output "rg_tags" {
  description = "A list of tag maps applied to the created resource groups."
  value       = azurerm_resource_group.resource_group[*].tags
}

output "workload_output" {
  description = "The name of the workload or application used in the resource group name."
  value       = var.workload
}