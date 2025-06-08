# configure the azure resource provider and the version used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }

  # set the hashicorp HCP terraform organisation + workspace for remote state file
  cloud {
    organization = "danzure-org"
    workspaces {
      name = "azure-virtual-desktop"
    }
  }
}

# configure the Microsoft Azure Provider
provider "azurerm" {
  features {

  }
}

# configure the 'random' provider
provider "random" {

}