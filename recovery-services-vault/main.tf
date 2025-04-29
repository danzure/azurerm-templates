# create the resource group
resource "azurerm_resource_group" "rsv_rg" {
  location = var.location
  tags     = var.tags

  name = format("rg-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )
}

# create the recovery services vault
resource "azurerm_recovery_services_vault" "rsv" {
  resource_group_name = azurerm_resource_group.rsv_rg.name
  location            = azurerm_resource_group.rsv_rg.location
  
  name = format("rsv-%s-%s-%s-001",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )

  sku                           = var.rsv_sku
  public_network_access_enabled = var.rsv_network_access
  cross_region_restore_enabled  = var.rsv_region_restore
  storage_mode_type             = var.rsv_storage_mode
  soft_delete_enabled           = var.rsv_soft_delete
  immutability                  = var.rsv_immutability
  tags                          = var.tags

  depends_on = [ azurerm_resource_group.rsv_rg ]
}

resource "azurerm_backup_policy_file_share" "rsv_file_bkp" {
  resource_group_name = azurerm_resource_group.rsv_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
  name = "AzureFileBackup"

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time = "23:00"
  }

  retention_daily {
    count = 10
  }

  retention_monthly {
    count = 6
    weekdays = [ "Sunday" ]
    weeks    = [ "Last" ]
  }
}