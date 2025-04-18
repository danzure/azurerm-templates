# deploy the azure firewall resource group
resource "azurerm_resource_group" "resource_group" {
  name = format("rg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  location = var.location
  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}