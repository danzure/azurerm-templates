# deploy resource group 
resource "azurerm_resource_group" "sandbox_rg" {
  name     = "rg-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  location = var.location
  tags     = var.tags
}

# deploy automation account resource
resource "azurerm_automation_account" "sandbox_aa" {
  name                = "aa-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  sku_name            = "Basic" # [Basic, Free]
  tags                = var.tags
}

# deploy key vault resource
resource "azurerm_key_vault" "sandbox_kv" {
  name                       = "kv-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name        = azurerm_resource_group.sandbox_rg.name
  location                   = azurerm_resource_group.sandbox_rg.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard" # [standard, premium]
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

# deploy log analytics workspace 
resource "azurerm_log_analytics_workspace" "sandbox_log" {
  name                = "log-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  tags                = var.tags
}

# create a random string for storage account name
resource "random_string" "random" {
  length  = 16
  special = false # No special characters allowed.
  upper   = false # Only lowercase letters allowed.
  numeric = true  # Numbers are allowed.
}

# deploy storagae account resource
resource "azurerm_storage_account" "sandbox_sa" {
  name                     = "sa${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.sandbox_rg.name
  location                 = azurerm_resource_group.sandbox_rg.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
  tags                     = var.tags
}