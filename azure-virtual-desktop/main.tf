# create the primaray resource group for the avd resources
resource "azurerm_resource_group" "avd_rg" {
  name = format("rg-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  location = var.location
  tags     = var.avd_tags

  lifecycle {
    create_before_destroy = true
  }
}

# create the virtual desktop workspace
resource "azurerm_virtual_desktop_workspace" "avd_vdws" {
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location

  name = format("vdws-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  friendly_name = var.workspace_friendly_name
  description   = "${var.workload}-avd-workspace"
  tags          = var.avd_tags
}

# create the avd host pool resource
resource "azurerm_virtual_desktop_host_pool" "avd_vdpool" {
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location

  name = format("vdpool-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  friendly_name = "${var.workload}-hostpool"
  description   = "Hostpool for ${var.workload}"
  tags          = var.avd_tags

  start_vm_on_connect  = true
  validate_environment = true

  load_balancer_type       = "DepthFirst" #[BreadthFirst, DepthFirst]
  type                     = "Pooled"     #[Pooled, Personal]
  maximum_sessions_allowed = 5
  preferred_app_group_type = "Desktop" #[Desktop, RemoteApp]

  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 3
    }
  }
}

# create the registration info for the hostpool
resource "azurerm_virtual_desktop_host_pool_registration_info" "vdpool_registration" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.avd_vdpool.id
  expiration_date = var.rfc3339time

  depends_on = [azurerm_virtual_desktop_host_pool.avd_vdpool]
}

# create the azure virtal desktop application group (DAG)
resource "azurerm_virtual_desktop_application_group" "avd_dag" {
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location
  host_pool_id        = azurerm_virtual_desktop_host_pool.avd_vdpool.id

  name = format("vdag-%s-%s-%s-${var.instance_number}",
    local.generate_resource_name.envrionment,
    local.generate_resource_name.workload,
    local.generate_resource_name.location
  )
  friendly_name = "DAG for ${var.workload}"
  description   = "${var.workload} Desktop Application Group"
  type          = "Desktop" #[RemoteApp, Desktop]
  tags          = var.avd_tags
  
  depends_on = [azurerm_resource_group.avd_rg]
}

# associate the avd workspace + DAG to the configuration
resource "azurerm_virtual_desktop_workspace_application_group_association" "vdws_dag_associate" {
  workspace_id         = azurerm_virtual_desktop_workspace.avd_vdws.id
  application_group_id = azurerm_virtual_desktop_application_group.avd_dag.id
}