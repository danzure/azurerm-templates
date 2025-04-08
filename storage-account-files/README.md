# Azure Storage Account Files Terraform Configuration

This repository contains Terraform configurations for deploying an `Azure Files Storage Account `. The purpose of this repository is to provide an easy method for deploying a storage account resource containing an SMB file share that be used for file storeage or any other applicible means

## Repository Structure

Below is a detailed list of each file in this repository and its purpose:

- **main.tf**: This file contains the main configuration of the primary resourcs for the Azure Files Storage Account. This includes the main resource group, storage account & file share

- **outputs.tf**: This file defines the outputs of the Terraform configuration. It provides useful information about the deployed resources, which can be used for further configuration or integration.

- **providers.tf**: This file specifies the providers required for the Terraform configuration. It includes the Azure provider and any other necessary providers for the deployment.

- **README.md**: This file provides an overview of the repository and detailed information about each file and its purpose.

- **variables.tf**: This file contains the variable definitions used in the Terraform configuration. It allows for customization of the deployment by setting values for various parameters such as: location, workload/ application. 

## Getting Started

To deploy the `storage-account-files` using this Terraform configuration, follow these steps:

1. Clone this repository to your local machine.
2. Install Terraform if you haven't already.
3. Configure your Azure credentials.
4. Customize the `variables.tf` file to suit your own envrionment(s)
5. Run `terraform init` to initialize the configuration.
6. Run `terraform plan` to review the planned changes.
7. Run `terraform apply` to deploy the AVD solution.
8. Troubleshoot & perform any additional required configuration.

For more information please see the following: `https://developer.hashicorp.com/terraform/tutorials` & `https://learn.microsoft.com/en-us/azure/virtual-desktop/`

## Contributing

If you would like to contribute to this repository, please fork the repository and submit a pull request with your changes. I welcome any contributions that improve the functionality, security, and usability of the configuration.

## Authors
Daniel Powley

## License

This repository is licensed under the MIT License. See the `LICENSE` file for more information.