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

variable "location" {
  description = "Specified the location the resources will be deployed too, this value will be added to the resource name"
  type        = string
  default     = "uksouth"
}

variable "envrionment" {
  description = "The production level of the resources (d = dev/ p = prod)"
  type        = string
  default     = "d"
}

variable "workload" {
  description = "The name of the workload or application for the firewall deployment"
  type        = string
  default     = "infra"
}

variable "tags" {
  description = "The tags to be applied to resources"
  default = {
    Envrionment = "Dev"
    Workload = "Firewall"
    Deployment = "Terraform"
  }
}

variable "vnet_address_space" {
  description = "value"
  default = ["10.10.0.0/22"]
}

variable "data_subnet_range" {
  description = "value"
  default = ["10.10.0.0/24"]
}

variable "firewall_subnet_range" {
  description = "value"
  default = ["10.10.1.0/26"]
}