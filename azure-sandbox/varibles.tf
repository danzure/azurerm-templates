variable "adds_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the Active Directory Domain Services subnet."
  type        = list(string)
  default     = ["10.10.0.0/24"]
}

variable "app_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the application subnet."
  type        = list(string)
  default     = ["10.20.0.0/24"]
}

variable "app_vnet_address_space" {
  description = "The address space (CIDR block) for the application virtual network."
  type        = list(string)
  default     = ["10.20.0.0/22"]
}

variable "bas_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the Bastion subnet."
  type        = list(string)
  default     = ["10.10.1.0/26"]
}

variable "db_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the database subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "environment" {
  description = "The deployment environment. Valid values are 'prod', 'uat', or 'dev'."
  type        = string
  default     = "dev" # [prod, uat, dev]
}

variable "firewall_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the firewall subnet."
  type        = list(string)
  default     = ["10.10.1.64/26"]
}

variable "jumpbox_admin_password" {
  description = "The password for the administrator account on the Windows jumpbox virtual machine."
  type        = string
  default     = "Ch@ngeMe123!"
  sensitive   = true
}

variable "jumpbox_admin_user" {
  description = "The username for the administrator account on the Windows jumpbox virtual machine."
  type        = string
  default     = "azure-admin"
}

variable "jumpbox_sku" {
  description = "The Azure VM SKU (size) to use for the Windows jumpbox virtual machine."
  type        = string
  default     = "Standard_F2"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "eastus"
}

variable "mssql_admin_password" {
  description = "The password for the administrator account on the Windows MSSQL virtual machine."
  type        = string
  default     = "Ch@ngeMe123!"
  sensitive   = true
}

variable "mssql_admin_user" {
  description = "The username for the administrator account on the Windows MSSQL virtual machine."
  type        = string
  default     = "azure-admin"
}

variable "mssql_sku" {
  description = "The Azure VM SKU (size) to use for the Windows MSSQL virtual machine."
  type        = string
  default     = "Standard_F2"
}

variable "privlink_snet_address_prefix" {
  description = "The address prefix (CIDR block) for the private link subnet."
  type        = list(string)
  default     = ["10.20.2.0/24"]
}

variable "shared_vnet_address_space" {
  description = "The address space (CIDR block) for the shared virtual network."
  type        = list(string)
  default     = ["10.10.0.0/22"]
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  default = {
    Envrionment = "Development"
    Workload    = "AzureSandbox"
    Deployment  = "Terraform"
  }
}

variable "workload" {
  description = "The name of the workload or application being deployed."
  type        = string
  default     = "sandbox"
}