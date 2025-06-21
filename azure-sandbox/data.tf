# get the tenant id from the tenant_id_output to deploy azure key vault
data "azurerm_client_config" "current" {
}

data "azurerm_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = "example-resources"
}