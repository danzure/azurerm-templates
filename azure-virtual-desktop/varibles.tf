variable "admin_password" {
  description = "The local administrator password for the Azure Virtual Desktop (AVD) session host(s)."
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "admin_username" {
  description = "The local administrator username for the Azure Virtual Desktop (AVD) session host(s)."
  type        = string
  default     = "azureadmin"
}

variable "avd_host_registration" {
  description = "The URL for the AVD host registration PowerShell DSC configuration ZIP file."
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}

variable "avd_registration_modules_url" {
  description = "The URL for the AVD registration DSC modules ZIP file."
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip"
}

variable "avd_tags" {
  description = "A map of tags to apply to all Azure Virtual Desktop resources."
  default = {
    Deployment  = "Terraform"
    Workload    = "AVD"
    Environment = "Development"
  }
}

variable "domain_join_upn" {
  description = "The username (without domain) for the account used to join AVD hosts to the Active Directory domain."
  type        = string
  default     = "domainjoinuser"
}

variable "domain_name" {
  description = "The Active Directory domain name to join the AVD session host(s) to."
  type        = string
  default     = "hosts.local"
}

variable "domain_ou_path" {
  description = "The distinguished name (DN) of the Organizational Unit (OU) where AVD hosts will be joined in Active Directory."
  type        = string
  default     = ""
}

variable "domain_password" {
  description = "The password for the domain join account (used to authenticate the domain join operation)."
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "environment" {
  description = "The deployment environment for the AVD resources. Possible values: dev, uat, prod."
  type        = string
  default     = "dev"
}

variable "fsl_quota" {
  description = "The storage quota (in GB) for the FSLogix file share."
  default     = "5"
}

variable "hostpool_max_sessions" {
  description = "The maximum number of user sessions allowed per AVD session host in the host pool."
  default     = "5"
}

variable "instance_number" {
  description = "The instance number for resource naming (e.g., 001, 002). Appended to resource names for uniqueness."
  type        = string
  default     = "001"
}

variable "location" {
  description = "The Azure region where resources will be deployed (e.g., uksouth, eastus)."
  type        = string
  default     = "uksouth"
}

variable "log_analytics_retention" {
  description = "The retention period (in days) for Log Analytics workspace data."
  default     = "30"
}

variable "log_analytics_sku" {
  description = "The SKU for the Log Analytics workspace. Possible values: PerGB2018, Premium, Standard."
  default     = "PerGB2018"
}

variable "msix_quota" {
  description = "The storage quota (in GB) for the MSIX app attach file share."
  default     = "5"
}

variable "network_tags" {
  description = "A map of tags to apply to network infrastructure resources."
  default = {
    Deployment  = "Terraform"
    Workload    = "Infrastructure"
    Environment = "Dev"
  }
}

variable "network_workload" {
  description = "The workload or application name used for naming network resources."
  type        = string
  default     = "infra"
}

variable "os_disk_type" {
  description = "The storage account type for the OS disk of the AVD session host(s) (e.g., Standard_LRS, Premium_LRS)."
  default     = "Standard_LRS"
}

variable "prefix" {
  description = "The prefix used in the naming of AVD session host(s) and related resources."
  type        = string
  default     = "avdtf"
}

variable "rdsh_count" {
  description = "The number of Remote Desktop Session Hosts (RDSH) to deploy for the AVD environment."
  type        = number
  default     = 1
}

variable "rfc3339time" {
  description = "The expiration date and time (RFC3339 format) for the AVD host registration token."
  default     = "2025-07-20T23:40:52Z"
}

variable "snet_address_prefix" {
  description = "The IP address prefix (CIDR) for the AVD subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "storage_account_tags" {
  description = "A map of tags to apply to storage accounts used by AVD."
  default = {
    Workload   = "FSLogix"
    Deployment = "Terraform"
  }
}

variable "vm_size" {
  description = "The Azure VM size for the AVD session host(s) (e.g., Standard_B2s)."
  type        = string
  default     = "Standard_B2s"
}

variable "vnet_address_space" {
  description = "The IP address space (CIDR) for the virtual network."
  type        = string
  default     = "10.10.0.0/22"
}

variable "workload" {
  description = "The workload or application name for Azure Virtual Desktop resources."
  type        = string
  default     = "tfavd"
}

variable "workspace_friendly_name" {
  description = "The friendly display name for the Azure Virtual Desktop workspace."
  type        = string
  default     = "Terraform AVD"
}