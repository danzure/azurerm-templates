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

variable "location" {
  description = "Specifies the azure region the resources will be deployed too"
  type        = string
  default     = "westeurope"
}

variable "privlink_snet_address_prefix" {
  description = "value"
  type        = list(string)
  default     = ["10.20.2.0/24"]
}

variable "shared_vnet_address_space" {
  description = "value"
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

variable "workload" {
  description = "Specifies name of the workload or application for the deployment"
  type        = string
  default     = "sandbox"
}