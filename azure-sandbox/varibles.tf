# creates a local map of location abbriviations for some of the most common azure regions (add & remove these as necessary)
locals {
  location_abbr = {
    "uksouth"        = "uks"  # UK South [Europe]
    "westeurope"     = "weu"  # West Europe [Europe]
    "northeurope"    = "neu"  # North Europe [Europe]
    "southcentralus" = "scus" # South Central US [US]
    "eastus"         = "eus"  # East US [US]
    "westus"         = "wus"  # West US [US]
    "australiaeast"  = "aue"  # Australia East [Asia]
    "japaneast"      = "jpe"  # Japan East [Asia]
    "southeastasia"  = "sea"  # South East Asia [Asia]
  }

  # function to generate resource name using the envrionment, workload & location prefix
  generate_resource_name = {
    location    = local.location_abbr[var.location],
    envrionment = var.envrionment
    workload    = var.workload
  }
}

variable "envrionment" {
  description = "Specifies the production level of the resources (d = dev/ p = prod), this will be added to the rg nam"
  type        = string
  default     = "d"
}

variable "workload" {
  description = "Specifies the workload or appliction for the resource group, this will be added to the rg name"
  type        = string
  default     = "sandbox"
}

variable "location" {
  description = "Specifies the location the resources will be deployed too, this will be added to the rg name"
  type        = string
  default     = "uksouth"
}

variable "tags" {
  description = "value"
  default = {
    Envrionment = "Dev"
    Workload = "Sandbox"
    Deployment = "Terraform IaC"
  }
}

variable "vnet_instance01" {
  description = "value"
  type = string
  default = "001"
}

variable "vnet_instance02" {
  description = "value"
  type = string
  default = "002"
}

variable "shared_vnet_name" {
  description = "value"
  type = string
  default = "shared"
}
