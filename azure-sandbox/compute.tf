# deploy windows jumpbox network interface card
resource "azurerm_network_interface" "win_jumpbox_nic" {
  name                = "nic-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.app_snet.id
  }
}

# deploy windows jumpbox to the application vnet
resource "azurerm_windows_virtual_machine" "win_jumpbox" {
  name                  = "Win-Jumpbox"
  resource_group_name   = azurerm_resource_group.sandbox_rg.name
  location              = azurerm_resource_group.sandbox_rg.location
  network_interface_ids = [azurerm_network_interface.win_jumpbox_nic.id]
  size                  = var.jumpbox_sku
  admin_username        = var.jumpbox_admin_user
  admin_password        = var.jumpbox_admin_password

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacentre"
    version   = "latest"
  }
}

resource "azurerm_mssql_virtual_machine" "mssql_vm" {
  virtual_machine_id               = data.azurerm_virtual_machine.example.id
  sql_license_type                 = "PAYG"
  r_services_enabled               = true
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "Password1234!"
  sql_connectivity_update_username = "sqllogin"

  auto_patching {
    day_of_week                            = "Sunday"
    maintenance_window_duration_in_minutes = 60
    maintenance_window_starting_hour       = 2
  }
}