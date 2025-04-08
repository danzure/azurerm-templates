# Random string to create unique ID for the storage account
resource "random_string" "storageAccountRandomString" {
  length = 8
  upper = false
  lower = true
  special = false
}

# create the primaray resource group for the avd resources
resource "azurerm_resource_group" "sa_resource_group" {
  name = format("rg-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  
  location = var.location
  tags     = var.tags
}

# Deploys the storage account with a random number string
resource "azurerm_storage_account" "storage_account" { 
resource_group_name = azurerm_resource_group.sa_resource_group.name
location = azurerm_resource_group.sa_resource_group.location

name = "sadtrfm${random_string.storageAccountRandomString.result}"
account_kind = "StorageV2" # [StorageV2, FileStorage]
account_tier = "Standard" # [Hot, Cool, Cold, Premium] 
account_replication_type = "LRS" # [LRS, GRS, ZRS, RAGRS, GZRS]

cross_tenant_replication_enabled = false # default [false, true]
public_network_access_enabled = false # default [false, true]

tags = var.tags
}

# Create the Azure File share
resource "azurerm_storage_share" "fileShare" {
  storage_account_id = azurerm_storage_account.storage_account.id
  
  name = var.file_share_name
  quota = var.storage_account_quota
  enabled_protocol = "SMB"
  depends_on = [ azurerm_resource_group.sa_resource_group, azurerm_storage_account.storage_account ]
}