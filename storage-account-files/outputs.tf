output "rg_name_output" {
  description = "output the name of the resource group"
  value = azurerm_resource_group.sa_resource_group.name
}

output "location_output" {
  description = "output the location the resources will be deployed too"
  value = var.location
}

output "sa_name_output" {
  description = "output the name of the storage account"
  value = azurerm_storage_account.storage_account.name
}

output "fileshare_url_output" {
  description = "outputs the url share name of the file share"
  value = azurerm_storage_share.fileShare.url
}

output "fileshare_quota_output" {
  description = "outputs the quota of the file share"
  value = azurerm_storage_share.fileShare.quota
}