# deploy log analytics workspace 
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name = format("log-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location
  sku                 = "PerGB2018" # [PerGB2018, Premium, Standard]
  retention_in_days   = "30"        # [adjust this as required]
  tags                = var.avd_tags

  depends_on = [azurerm_resource_group.avd_rg]
}