variable "envrionment" {
  description = "Specifies the production level of the resources (d = dev/ p = prod), this will be added to the rg nam"
  type        = string
  default     = "d"
}

variable "workload" {
  description = "Specifies the workload or appliction for the resource group, this will be added to the rg name"
  type        = string
  default     = "trfm"
}

variable "location" {
  description = "Specifies the location the resources will be deployed too, this will be added to the rg name"
  type        = string
  default     = "uksouth"
}

variable "rg_count" {
  description = "Specifies the number of resource groups to deploy"
  default     = 1
}

variable "resource_tags" {
  description = "Specifies the tags that will be applied to the resource group(s)"
  default = {
    Deployment  = "IaC"
    Envrionment = "Dev"
    Workload    = "Terraform"
  }
}