terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
  
  # set the hashicorp HCP terraform organisation + workspace for remote state file (remove if unused)
  cloud {
    organization = "danzure-org" # specifiy your own organistation name
    workspaces {
      name = "recovery-services-vault" # specify your own workspace
    }
  }
}

provider "azurerm" {
  # Configuration options for resources
  features {
    recovery_services_vaults {
      # additional vault service configuration
    }
  }
}