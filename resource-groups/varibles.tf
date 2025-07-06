variable "environment" {
  description = "Specifies the deployment environment. Allowed values: 'prod', 'uat', or 'dev'."
  type        = string
  default     = "dev" # [prod, uat, dev]
}

variable "location" {
  description = "Azure region where resources will be deployed. This value is appended to the resource group name."
  type        = string
  default     = "uksouth"
}

variable "resource_tags" {
  description = "A map of tags to apply to all resource groups created by this module."
  default = {
    Deployment  = "IaC"
    Envrionment = "Dev"
    Workload    = "Terraform"
  }
}

variable "rg_count" {
  description = "Number of resource groups to create."
  default     = 1
}

variable "workload" {
  description = "Name of the workload or application. This value is appended to the resource group name."
  type        = string
  default     = "trfm"
}