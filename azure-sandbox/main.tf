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
resource "azurerm_automation_account" "automation_acc" {
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