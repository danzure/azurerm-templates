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
  description = "The name of the workload or application for the Azure Storage Account"
  type        = string
  default     = "fileshare"
}

# resource tagging varible
variable "tags" {
  description = "Standard tags to be applied to resources"
  default = {
   Deployment = "Terraform"
   Production = "Dev/Test"
   Workload = "SMB Storage"
  }
}

# Resource Group Name
variable "instance_number" {
  description = "The numbered instance for the resource group"
  type = string
  default = "001"
}

# fileshare name 
variable "file_share_name" {
  description = "Specify the name of the file share" # [lowercase only]
  default = "fileshare"
}

# storage account quote
variable "storage_account_quota" {
  description = "The amount of storage for the file share in GiB"
  default = "100"
}