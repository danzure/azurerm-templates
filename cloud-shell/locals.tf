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
  generate_loc_name = {
    location = local.location_abbr[var.location]
  }
}

locals {
  environment_abbr = {
    "prod" = "p" # Production envrionment
    "uat"  = "u" # User Acceptance Testing (UAT) envrionment
    "dev"  = "d" # Development envrionment
  }
  # function to generate the abbriviation for the azure region 
  generate_env_name = {
    environment = local.environment_abbr[var.environment]
  }
}