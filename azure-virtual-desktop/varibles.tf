variable "admin_password" {
  description = "Local administrator password for the Azure Virtual Desktop (AVD) host(s)."
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "admin_username" {
  description = "Local administrator username for the AVD host(s)."
  type        = string
  default     = "azureadmin"
}

variable "avd_host_registration" {
  description = "URL for the AVD host registration PowerShell DSC configuration."
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}

variable "avd_tags" {
  description = "Tags to be applied to all Azure Virtual Desktop resources."
  default = {
    Deployment  = "Terraform"
    Workload    = "AVD"
    Environment = "Development"
  }
}

variable "domain_join_upn" {
  description = "Username (without domain) for the account used to join AVD hosts to the domain."
  type        = string
  default     = "domainjoinuser" # do not include the domain name, this is appended
}

variable "domain_name" {
  description = "Active Directory domain name to join the AVD host(s) to."
  type        = string
  default     = "hosts.local"
}

variable "domain_ou_path" {
  description = "Distinguished Name (DN) of the Organizational Unit (OU) where AVD hosts will be joined."
  type        = string
  default     = "" # [Enter the domain OU path here]
}

variable "domain_password" {
  description = "Password for the domain join account (used to authenticate the domain join operation)."
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "environment" {
  description = "Deployment environment for the AVD resources. Possible values: dev, uat, prod."
  type        = string
  default     = "dev" # possible options [dev, uat, prod]
}

variable "fsl_quota" {
  description = "Storage quota (in GB) for the FSLogix file share."
  default     = "5"
}

variable "instance_number" {
  description = "Instance number for resource naming (e.g., 001, 002). Appended to resource names for uniqueness."
  type        = string
  default     = "001"
}

variable "location" {
  description = "Azure region where resources will be deployed (e.g., uksouth, eastus)."
  type        = string
  default     = "uksouth"
}

variable "msix_quota" {
  description = "Storage quota (in GB) for the MSIX app attach file share."
  default     = "5"
}

variable "network_tags" {
  description = "Tags to be applied to network infrastructure resources."
  default = {
    Deployment  = "Terraform"
    Workload    = "Infrastructure"
    Environment = "Dev"
  }
}

variable "network_workload" {
  description = "Workload or application name used for naming network resources."
  type        = string
  default     = "infra"
}

variable "prefix" {
  description = "Prefix used in the naming of AVD host(s) and related resources."
  type        = string
  default     = "avdtf"
}

variable "rdsh_count" {
  description = "Number of Remote Desktop Session Hosts (RDSH) to deploy for the AVD environment."
  type        = number
  default     = 1 # default [1]
}

variable "rfc3339time" {
  description = "Expiration date and time (RFC3339 format) for the AVD host registration token."
  default     = "2025-07-20T23:40:52Z" # update the registration date to be within 7 days
}

variable "snet_address_prefix" {
  description = "IP address prefix (CIDR) for the AVD subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "storage_account_tags" {
  description = "Tags to be applied to storage accounts used by AVD."
  default = {
    Workload   = "FSLogix"
    Deployment = "Terraform"
  }
}

variable "vm_size" {
  description = "Azure VM size for the AVD host(s) (e.g., Standard_B2s)."
  type        = string
  default     = "Standard_B2s"
}

variable "vnet_address_space" {
  description = "IP address space (CIDR) for the virtual network."
  type        = string
  default     = "10.10.0.0/22"
}

variable "workload" {
  description = "Workload or application name for Azure Virtual Desktop resources."
  type        = string
  default     = "tfavd"
}

variable "workspace_friendly_name" {
  description = "Friendly display name for the Azure Virtual Desktop workspace."
  type        = string
  default     = "Terraform AVD"
}