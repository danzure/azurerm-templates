# deploy resource group 
resource "azurerm_resource_group" "sandbox_rg" {
  name = format("rg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  location = var.location
  tags     = var.tags
}

# get the tenant id from the tenant_id_output to deploy azure key vault
data "azurerm_client_config" "current" {
}

# deploy automation account resource
resource "azurerm_automation_account" "sandbox_aa" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

  name = format("aa-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  sku_name = "Basic" # [Basic, Free]

  depends_on = [ azurerm_resource_group.sandbox_rg ]
}

# deploy key vault resource
resource "azurerm_key_vault" "sandbox_kv" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tenant_id = data.azurerm_client_config.current.tenant_id

  name = format("kv-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )

  sku_name = "standard" # [standard, premium]
  soft_delete_retention_days = 7
  purge_protection_enabled = false

  depends_on = [ azurerm_resource_group.sandbox_rg ]
}

# deploy log analytics workspace 
resource "azurerm_log_analytics_workspace" "sandbox_law" {
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location = azurerm_resource_group.sandbox_rg.location
  tags = var.tags

   name = format("law-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  retention_in_days = 30

  depends_on = [ azurerm_resource_group.sandbox_rg ]
}

# deploy storagae account resource
