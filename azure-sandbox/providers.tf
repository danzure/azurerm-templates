terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }

  # set the hashicorp HCP terraform organisation + workspace for remote state file
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

provider "random" {

}