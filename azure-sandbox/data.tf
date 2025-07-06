# get the tenant id from the tenant_id_output to deploy azure key vault
data "azurerm_client_config" "current" {
}

data "azurerm_virtual_machine" "mssql_vm_data" {
  name                = azurerm_windows_virtual_machine.mssql_vm.id
  resource_group_name = azurerm_resource_group.sandbox_rg.name
}