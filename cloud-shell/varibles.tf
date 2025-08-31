variable "sa_replication" {
  description = "Specifies the replication for the storage account [LRS, GRS, ZRS]"
  type        = string
  default     = "LRS" #[LSR, GRS, ZRS]
}

variable "environment" {
  description = "Specifies the deployment environment. Allowed values [prod, uat, dev]"
  type        = string
  default     = "dev" # [prod, uat, dev]
}

variable "location" {
  description = "Azure region where resources will be deployed. This value is appended to the resource group name."
  type        = string
  default     = "westeurope"
}

variable "resource_tags" {
  description = "A map of tags to apply to all resource groups created by this module."
  default = {
    Deployment  = "IaC"
    Envrionment = "Dev"
    Workload    = "Terraform"
  }
}

variable "workload" {
  description = "Name of the workload or application. This value is appended to the resource group name."
  type        = string
  default     = "cloudshell"
}