# The location, environment & workload variables will all be abbreviated and used in the resource naming convention listed below

variable "admin_password" {
  description = "Local admin password for the AVD host(s)"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "admin_username" {
  description = "Local admin username for the AVD host(s)"
  type        = string
  default     = "azureadmin"
}

variable "avd_host_registration" {
  description = "Variable to attach the virtual machine to the AVD host pool"
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}

variable "avd_tags" {
  description = "Tagging to be applied to the resources"
  default = {
    Deployment  = "Terraform"
    Workload    = "AVD"
    Environment = "Development"
  }
}

variable "domain_join_upn" {
  description = "The username for the account to join the domain"
  type        = string
  default     = "domainjoinuser" # do not include the domain name, this is appended
}

variable "domain_name" {
  description = "The domain the AVD host(s) will be joined to"
  type        = string
  default     = "hosts.local"
}

variable "domain_ou_path" {
  description = "The OU the AVD machines will be joined to"
  type        = string
  default     = "" # [Enter the domain OU path here]
}

variable "domain_password" {
  description = "Password for the user to authenticate the join to the domain"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "environment" {
  description = "Specify the production environment"
  type        = string
  default     = "dev" # possible options [dev, uat, prod]
}

variable "fsl_quota" {
  description = "Set the storage quota (GB) for the FSLogix file share"
  default     = "5"
}

variable "instance_number" {
  description = "The instance number of the resources (001, 002 etc.) this will be added at the end of the name"
  type        = string
  default     = "001"
}

variable "location" {
  description = "Specified the region deployment location"
  type        = string
  default     = "uksouth"
}

variable "msix_quota" {
  description = "Set the storage quota (GB) for the FSLogix file share"
  default     = "5"
}

variable "network_tags" {
  description = "Tagging applied to network infrastructure resources"
  default = {
    Deployment  = "Terraform"
    Workload    = "Infrastructure"
    Environment = "Dev"
  }
}

variable "network_workload" {
  description = "Specify the workload/application name for the virtual network resources"
  type        = string
  default     = "infra"
}

variable "prefix" {
  description = "Prefix name for the name of the AVD host(s)"
  type        = string
  default     = "avdtf"
}

variable "rdsh_count" {
  description = "Set the number of remote desktop session hosts to deploy"
  type        = number
  default     = 1 # default [1]
}

variable "rfc3339time" {
  description = "Host registration token expiration date & time"
  default     = "2025-06-20T23:40:52Z" # update the registration date to be within 7 days
}

variable "snet_address_prefix" {
  description = "IP address prefix for the AVD subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "storage_account_tags" {
  description = "Tags to be applied to the storage account"
  default = {
    Workload   = "FSLogix"
    Deployment = "Terraform"
  }
}

variable "vm_size" {
  description = "Size of the virtual machine host(s)"
  type        = string
  default     = "Standard_B2s"
}

variable "vnet_address_space" {
  description = "IP address space for the virtual network"
  type        = string
  default     = "10.10.0.0/22"
}

variable "workload" {
  description = "The name of the workload/application name for the Azure Virtual Desktop resources"
  type        = string
  default     = "tfavd"
}

variable "workspace_friendly_name" {
  description = "Friendly name for the Azure Virtual Desktop workspace"
  type        = string
  default     = "Terraform AVD"
}