terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }

  # set the hashicorp HCP terraform organisation + workspace for remote state file (remove if unused)
  cloud {
    organization = "danzure-org" # specifiy your own organistation name
    workspaces {
      name = "azure-sandbox" # specify your own workspace
    }
  }
}

provider "azurerm" {
  # Configuration options for resources
  features {
  }
}