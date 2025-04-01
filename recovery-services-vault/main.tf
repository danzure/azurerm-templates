# create the resource group
resource "azurerm_resource_group" "rsv_rg" {
  location = var.location
  tags = var.tags

  name = format("rg-%s-%s-%s-${var.instance}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )
}

# create the recovery services vault
resource "azurerm_recovery_services_vault" "rsv" {
  resource_group_name = azurerm_resource_group.rsv_rg.name
  location = var.location
  tags = var.tags
  
  name = format("rsv-%s-%s-%s-${var.instance}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
    )

  sku = var.rsv_sku
  storage_mode_type = var.rsv_storage_mode 
  soft_delete_enabled = var.rsv_soft_delete
  immutability = var.rsv_immutability
  public_network_access_enabled = var.rsv_network_access
  cross_region_restore_enabled = var.rsv_region_restore

  depends_on = [ azurerm_resource_group.rsv_rg ]
}

resource "azurerm_backup_policy_vm" "vm_daily_policy" {
  resource_group_name = azurerm_resource_group.rsv_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
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
    weekdays = [ "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday" ]
  }
}