# Hub-Spoke Terraform Configuration

This repository contains Terraform configuration for deploying an `Hub-spoke virtual network` topology. Hub-spoke networks are reccomended under the cloud adoption framework, it is generally considered best practice for most organisations. The `hub` virtual network acts as a point of connectivity for each `spoke` virtual network that may host seperate workloads. You can read more about hub-spoke virtual network here: <a href ="https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/hub-spoke">Hub-Spoke Topology</a>

## Repository Structure
Below is a detailed list of each file in this repository and its purpose:

- **locals.tf**: This contains the local values within the terraform configuration for the resource name convention that creates a map & abbriviation values. 

- **main.tf**: Contains the core terraform configuration, including the `Resource Group`, `Hub-Spoke Virtual Network`, `Bastion Host` & `AzureFirewall` configuration. 

- **outputs.tf**: This file defines the outputs of the Terraform configuration. It provides useful information about the deployed resources

- **peerings.tf**: This file contains the configuration for the dynamic peering between the the hub virtual network and each deployed spoke virtual network. 

- **providers.tf**: This file provides the essential components & plug-ins for deploying the configuration file. 

- **README.md**: This file provides an overview of the repository and detailed information about each file and its purpose.

- **variables.tf**: Contains the variable definitions used in the file for setting values for different parameters of the configuration.

## Getting Started

To deploy the `hub-spoke` network using this Terraform configuration, follow these basic steps:

1. Install the Terraform CLI 
2. Create a clone of this repository to your local machine
3. Login & configure your Azure credentials
4. Customize the different options within the `variables.tf` file. 
5. Run `terraform init` to initialize the configuration.
6. Run `terraform plan` to review the planned changes. 
7. Run `terraform apply` to deploy the hub-spoke virtual network
8. Troubleshoot & perform any additional required configuration.

For more detailed information, please see the following: `https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli`, `https://developer.hashicorp.com/terraform/tutorials`

## Contributing

If you would like to contribute to this repository, please fork the repository and submit a pull request with your changes. I welcome any contributions that improve the functionality, security, and usability of the configuration.

## Authors
Daniel Powley

## License

This repository is licensed under the MIT License. See the `LICENSE` file for more information.