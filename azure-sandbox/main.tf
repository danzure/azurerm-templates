# create the  sandbox resource group
resource "azurerm_resource_group" "sandbox_rg" {
  name = format("rg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  location = var.location
  tags     = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# deploy automation account
resource "azurerm_automation_account" "sandbox_aa" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location

  name = format("aa-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  
  sku_name = "Free" # [Basic, Free]
  tags = var.tags
}

# create an azure key vault
resource "azurerm_key_vault" "sandbox_kv" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tenant_id = data.azurerm_client_config.current.tenant_id

  name = format("kv-%s-%s-%s-${var.vnet_instance01}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )

  sku_name = "standard" # [standard, premium]
  soft_delete_retention_days = 7
  purge_protection_enabled = false
}

# create an log analytics workspace 

# create a storage account 

# get client configuration data
data "azurerm_client_config" "current" {
  
}