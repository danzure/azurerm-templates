terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.39.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }

  # Configure Terraform Cloud for remote state management.
  # Replace 'danzure-org' with your Terraform Cloud organization name.
  cloud {
    organization = "danzure-org"
    
    workspaces {
      # Set the workspace name for this environment.
      name = "azure-sandbox"
      # Optional tags for workspace organization.
      tags = [ "Azure" ]
    }
  }
}

# Configure the AzureRM provider for managing Azure resources.
provider "azurerm" {
  features {
    # Enable or customize provider features here if needed.
  }
}

# Configure the Random provider for generating random values.
provider "random" {
  
}