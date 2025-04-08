terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }

  # set the hashicorp HCP terraform organisation + workspace for remote state file (remove if unused)
  cloud {
    organization = "danzure-org" # specifiy your own organistation name
    workspaces {
      name = "storage-account-files" # specify your own workspace
    }
  }
}

provider "azurerm" {
  # additional configuration options for resources
  features {
    
  }
}