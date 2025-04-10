# create the resource group
resource "azurerm_resource_group" "rsv_resource_group" {
  location = var.location
  tags     = var.tags

  name = format("rg-%s-%s-%s-${var.instance}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )
}

# create the recovery services vault
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  resource_group_name = azurerm_resource_group.rsv_resource_group.name
  location            = azurerm_resource_group.rsv_resource_group.location
  
  name = format("rsv-%s-%s-%s-${var.instance}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )
  sku = var.rsv_sku

  public_network_access_enabled = var.rsv_network_access
  cross_region_restore_enabled  = var.rsv_region_restore
  storage_mode_type             = var.rsv_storage_mode
  soft_delete_enabled           = var.rsv_soft_delete
  immutability                  = var.rsv_immutability
  tags                          = var.tags

  depends_on = [ azurerm_resource_group.rsv_resource_group ]
}

resource "azurerm_backup_policy_vm" "vm_backup_policy" {
  resource_group_name = azurerm_resource_group.rsv_resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_services_vault.name

  name = var.rsv_vm_backup_name
  timezone = var.backup_timezone

  backup {
    frequency = "Daily"
    time = "21:00"
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count = 1
    weekdays = [ "Monday","Wednesday","Friday","Saturday"]
  }

  retention_monthly {
    count = 7
    weekdays = ["Sunday"]
    weeks = [ "First", "Last" ]
  }

  retention_yearly {
    count = 77
    weekdays = ["Sunday"]
    weeks = ["Last"]
    months = [ "January" ]
  }
}