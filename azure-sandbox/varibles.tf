variable "adds_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.10.0.0/24"]
}

variable "app_vnet_address_space" {
  description = "value"
  type        = list(string)
  default     = ["10.20.0.0/22"]
}

variable "app_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.20.0.0/24"]
}

variable "bas_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.10.1.0/26"]
}

variable "db_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "environment" {
  description = "Specifies the production environment"
  type        = string
  default     = "dev" # [prod, uat, dev]
}

variable "firewall_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.10.1.64/26"]
}

variable "jumpbox_admin_password" {
  description = "Specify the password for the password for the jumpbox admin"
  type        = string
  default     = "Ch@ngeMe123!"
  sensitive   = true
}

variable "jumpbox_admin_user" {
  description = "Set the name of the administrator user for the windows jumpbox"
  type        = string
  default     = "azure-admin"
}

variable "location" {
  description = "Specifies the azure region the resources will be deployed too"
  type        = string
  default     = "westeurope"
}

variable "privlink_snet_address_prefix" {
  description = "Specify the address prefix for the the private link subnet"
  type        = list(string)
  default     = ["10.20.2.0/24"]
}

variable "shared_vnet_address_space" {
  description = "Specify the address space for the shared virtual network"
  type        = list(string)
  default     = ["10.10.0.0/22"]
}

variable "tags" {
  description = "Specifies the tags that will be applied resources"
  default = {
    Envrionment = "Development"
    Workload    = "AzureSandbox"
    Deployment  = "Terraform"
  }
}

variable "jumpbox_sku" {
  description = "Specifies the SKU used forh the Windows jumpbox virtual machine"
  type        = string
  default     = "Standard_F2"
}

variable "workload" {
  description = "Specifies name of the workload or application for the deployment"
  type        = string
  default     = "sandbox"
}