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

  # funcation to generate the vnet & subnet names with location prefix
  generate_network_name = {
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
  description = "The name of the workload or application for the network deployment"
  type        = string
  default     = "infra"
}

variable "tags" {
  description = "value"
  default = {
    Deployment = "Terraform"
    Workload = "Infrastructure"
    Environment = ""
  }
}

variable "instance_number" {
  description = "value"
  default = "001"
}

variable "vnet_address_space" {
  description = "value"
  default = "10.0.0.0/22"
}

variable "snet_address_prefix" {
  description = "value"
  default = "10.0.0.0/24"
}