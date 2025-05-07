variable "envrionment" {
  description = "Specifies the production environment, set to 'dev' by default (d= dev, u= uat, p= prod)"
  type        = string
  default     = "d"
}

variable "workload" {
  description = "Specifies name of the workload or application for the deployment"
  type        = string
  default     = "sandbox"
}

variable "location" {
  description = "Specifies the azure region the resources will be deployed too"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Specifies the tags that will be applied resources"
  default = {
    Envrionment = "Dev"
    Workload = "AzureSandbox"
    Deployment = "Terraform"
  }
}