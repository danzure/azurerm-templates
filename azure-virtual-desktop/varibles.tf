variable "location" {
  description = "Specified the location the resources will be deployed too, this value will be added to the resource name"
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "The production level of the resources"
  type        = string
  default     = "dev" # [dev, uat, prod]
}

variable "workload" {
  description = "The name of the workload or application for the AVD deployment"
  type        = string
  default     = "tfavd"
}

variable "rdsh_count" {
  description = "Number of remote desktop session hosts to deploy"
  type        = number
  default     = 1
}

variable "network_workload" {
  description = "Specifiy the workload name for the network resources"
  type        = string
  default     = "infra"
}

variable "avd_tags" {
  description = "Tagging to be applied to the resources"
  default = {
    Deployment  = "Terraform"
    Workload    = "AVD"
    Environment = "Development"
  }
}

variable "workspace_friendly_name" {
  description = "Friendly name for the azure virtual desktop workspace"
  type        = string
  default     = "Terraform AVD"
}

variable "vnet_address_space" {
  description = "IP address space for the virtual network"
  type        = string
  default     = "10.10.0.0/22"
}

variable "snet_address_prefix" {
  description = "IP address prefix for the AVD subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "network_tags" {
  description = "Tagging applied to network infrastructure resources"
  default = {
    Deployment  = "Terraform"
    Workload    = "Infrastructure"
    Envrionment = "Dev"
  }
}

variable "vm_size" {
  description = "Size of the virtual machine host(s)"
  type        = string
  default     = "Standard_B2s"
}

variable "prefix" {
  description = "Prefix name for the name of the AVD host(s)"
  type        = string
  default     = "avdtf"
}

variable "domain_ou_path" {
  description = "The OU the AVD machines will be joined too"
  type        = string
  default     = "" # [Enter the domain OU path here]
}

variable "instance_number" {
  description = "The instance number of the resources (001, 002 ect.) this will be added at the end of the name"
  type = string
  default = "001"
}

variable "domain_name" {
  description = "The domain the AVD host(s) will be joined too"
  type        = string
  default     = "hosts.local"
}

variable "domain_join_upn" {
  description = "The username for the account to join the domain"
  type        = string
  default     = "domainjoinuser" # do not include the domain name, this this appended
}

variable "domain_password" {
  description = "Password for the user to authenticate the join to the domain"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "admin_username" {
  description = "local admin username for the avd host(s)"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "local admin password for the avd host(s)"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "avd_host_registration" {
  description = "Varible to attach the virtual machine to the AVD host pool"
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}

variable "rfc3339time" {
  description = "Host registration token expiration date & time"
  default     = "2025-05-20T23:40:52Z" # update the registration date to be within 7 days
}

variable "storage_account_tags" {
  description = "Tags to be applied to the storage account"
  default = {
    Workload   = "FSLogix"
    Deployment = "Terraform"
  }
}

variable "fsl_quota" {
  description = "Set the storage quota (GB) for the FSLogix file share"
  default     = "5"
}

variable "msix_quota" {
  description = "Set the storage quota (GB) for the FSLogix file share"
  default     = "5"
} 