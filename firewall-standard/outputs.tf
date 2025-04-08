output "rg_name_output" {
  description = "Outputs the name of the firewall resource group"
  value = azurerm_resource_group.firewall_rg.name
}