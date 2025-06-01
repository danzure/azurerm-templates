# get the tenant id from the tenant_id_output to deploy azure key vault
data "azurerm_client_config" "current" {
}
