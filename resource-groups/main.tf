# create the resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-${format("%03d", count.index + 1)}"
  location = var.location
  count    = var.rg_count
  tags     = var.resource_tags
}