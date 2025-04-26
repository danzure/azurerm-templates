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

  # function to generate resource name using the 'resourcetype-environment-application-location-instance' standard
  generate_resource_name = {
    location    = local.location_abbr[var.location],
    envrionment = var.envrionment
    workload    = var.workload
  }
}

variable "envrionment" {
  description = "Specifies the production environment, set to 'dev' by default (d= dev, u= uat, p= prod)"
  type        = string
  default     = "d"
}

variable "workload" {
  description = "Specifies name of the workload or application for the deployment"
  type        = string
  default     = "sandbox"
}

variable "location" {
  description = "Specifies the azure region the resources will be deployed too"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Specifies the tags that will be applied resources"
  default = {
    Envrionment = "Dev"
    Workload = "AzureSandbox"
    Deployment = "Terraform"
  }
}