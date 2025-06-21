# Azure Virtual Desktop Terraform Configuration

This repository contains Terraform configuration for deploying an `Azure Sandbox` based on the architecture from the: <a href ="https://learn.microsoft.com/en-us/azure/architecture/guide/azure-sandbox/azure-sandbox">Azure Architecture Centre</a>. Azure Sandbox is a collection of interdependant configurations for implimenting common Azure services all within a single Azure `Subscription`. Where possible, any resources deployed as part of this configuration will be named dynamiclly using the following name convention: `resourcetype-environment-application-location-instance` based on some of the values within the `varibles.tf` file. 

## Please note: 
Depending on your Azure offer & deployment region, deploying the full `Azure Sandbox`configuration can be expensive to run. It's heavily advised to edit the configuration based on your own requirements by commenting out unessacary configuration using block comments `/*` to start a block comment, then `*/` to finish a block comment or removing any of the `.tf` configuration completely. 

## Repository Structure
Below is a detailed list of each file in this repository and its purpose:

- **compute.tf**: This file contains the configuration for the `Windows` & `Linux` jumpbox virtual machines

- **connectivity**: This file contains the configuration for connectivity between resources, this includes the peering between `Virtual Networks` and `Private Endpoint`

- **main.tf**: This file contains the main configuration of the primary resources including: `Resource Group`, `Key Vault`, `Log Analytics` & `Storage Account`

- **network.tf**: This file contains the configuration for the network infrastructure 

- **outputs.tf**: This file defines the outputs of the Terraform configuration. It provides useful information about the deployed resources

- **providers.tf**: This file specifies the providers required for the Terraform configuration. It includes the Azure provider and any other necessary providers for the deployment.

- **README.md**: This file provides an overview of the repository and detailed information about each file and its purpose.

- **variables.tf**: This file contains the variable definitions used in the Terraform configuration. It allows for customization of the deployment by setting values for various parameters such as: location, workload/ application, size & tagging. Please see file for full list. 

## Getting Started

To deploy the `Azure Sandbox` environment using this Terraform configuration, follow these basic steps:

1. Install the Terraform CLI 
2. Create a clone of this repository to your local machine
3. (Optional) Set the HCP organisation & workspace under `providers.tf` and login to HCP
4. Login using your Azure credentials
5. Customize the `variables.tf` file to suit your own envrionment. 
6. Run `terraform init` to initialize the configuration.
7. Run `terraform plan` to review the planned changes. 
8. Run `terraform apply` to deploy the Azure Sandbox
9. Troubleshoot & perform any additional required configuration.

For more detailed information, please see the following: `https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli`, `https://developer.hashicorp.com/terraform/tutorials`

## Contributing

If you would like to contribute to this repository, please fork the repository and submit a pull request with your changes. I welcome any contributions that improve the functionality, security, and usability of the configuration.

## Authors
Daniel Powley

## License

This repository is licensed under the MIT License. See the `LICENSE` file for more information.