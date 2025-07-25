terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }

  # set the hashicorp HCP terraform organisation + workspace for remote state file (remove if unused)
  cloud {
    organization = "danzure-org"
    workspaces {
      name = "resource-groups"
    }
  }
}

provider "azurerm" {
  # additional configuration options for resources
  features {
    resource_group {

    }
  }
}