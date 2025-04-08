output "rg_name_output" {
  description = "value"
  value = azurerm_resource_group.sa_resource_group.name
}

output "location_output" {
  description = "value"
  value = var.location
}

output "sa_name_output" {
  description = "value"
  value = azurerm_storage_account.storage_account.name
}

output "fileshare_url_output" {
  description = "value"
  value = azurerm_storage_share.fileShare.url
}

