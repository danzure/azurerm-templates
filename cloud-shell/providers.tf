terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }

  # Configure Terraform Cloud for remote state management.
  # Replace 'danzure-org' with your Terraform Cloud organization name.
  cloud {
    organization = "danzure-org"

    workspaces {
      # Set the workspace name for this environment.
      name = "cloud-shell"
    }
  }
}

# Configure the AzureRM provider for managing Azure resources.
provider "azurerm" {
  features {
    # Enable or customize provider features here if needed.
  }
}
