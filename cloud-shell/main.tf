# create the resource group
resource "azurerm_resource_group" "cloudshell_rg" {
  name     = "rg-${local.generate_env_name.environment}-${var.workload}-${local.generate_loc_name.location}-001"
  location = var.location
  tags     = var.resource_tags
}

resource "azurerm_storage_account" "cloudshell_sa" {
  name                     = "sacloudshe113433"
  resource_group_name      = azurerm_resource_group.cloudshell_rg.name
  location                 = azurerm_resource_group.cloudshell_rg.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = var.sa_replication
  tags                     = var.resource_tags
}

resource "azurerm_storage_share" "file_share" {
  name               = "cloud-shell"
  storage_account_id = azurerm_storage_account.cloudshell_sa.id
  access_tier        = "TransactionOptimized"
  enabled_protocol   = "SMB"
  quota              = "5"
}