# deploy windows jumpbox network interface card
resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "nic-${format("%s", local.generate_env_name.envrionment)}-${var.workload}-${format("%s", local.generate_loc_name.location)}-001"
  resource_group_name = azurerm_resource_group.sandbox_rg.name
  location            = azurerm_resource_group.sandbox_rg.location
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.app_snet.id
  }
  depends_on = [ azurerm_subnet.app_snet ]
}

# deploy windows jumpbox to the application vnet
resource "azurerm_windows_virtual_machine" "win_jumpbox" {
  name                  = "Jumpbox-VM"
  resource_group_name   = azurerm_resource_group.sandbox_rg.name
  location              = azurerm_resource_group.sandbox_rg.location
  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]
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
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}