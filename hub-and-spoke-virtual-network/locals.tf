# create a local map of location abbriviations for some common azure regions
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
    # <add any additional regions here>
  }
  # funcation to generate the location abbriviation
  generate_loc_name = {
    location = local.location_abbr[var.location]
  }
}

locals {
  envrionment_abbr = {
    "production"  = "p"
    "uat"         = "u"
    "development" = "d"
  }
  # function to generate the envrionment abbriviation 
  generate_env_name = {
    envrionment = local.envrionment_abbr[var.envrionment]
  }
}
