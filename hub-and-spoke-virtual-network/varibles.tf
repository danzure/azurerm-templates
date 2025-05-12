variable "envrionment" {
  description = "The production level of the resources"
  type        = string
  default     = "development" # value entered here will be abbriviated to 'd' for dev and included in resource name, see locals.tf for more details
}

variable "workload" {
  description = "The name of the workload or application for the network deployment"
  type        = string
  default     = "hubspoke"
}

variable "location" {
  description = "Specifies the deployment location for the resources"
  type        = string
  default     = "uksouth" # value entered here will be abbriviated to 'uks' and then added to resource name, see locals.tf for more details
}

variable "hub_vnet_addess_space" {
  description = "Specifies the address space for the hub virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hub_subnet_address_prefix" {
  description = "Specifies the address prefix for the hub subent"
  type        = string
  default     = "10.0.1.0/24"
}

variable "spoke_count" {
  description = "Specifies the number of spoke virtual networks to create"
  type        = number
  default     = "2" # change this value to 
  validation {
    condition     = var.spoke_count >= 0
    error_message = "The number of spokes must be zero or positive"
  }
}

variable "spoke_vnet_address_space_cidr" {
  description = "Base CIDR block that the address space for each spoke network will be calculated from"
  type        = string
  default     = "10.1.0.0/16"
  validation {
    condition     = tonumber(split("/", var.spoke_vnet_address_space_cidr)[1]) >= 1 && tonumber(split("/", var.spoke_vnet_address_space_cidr)[1]) <= 31
    error_message = "The base address space must have a valid CIDR prefix length (1-31)."
  }
}

variable "spoke_vnet_new_bits" {
  description = "Number of additional bits to subnet the base address space for each Spoke VNet (e.g., 8 for /24 spokes from a /16 base)."
  type        = number
  default     = 8 # Creates /24 networks from the /16 base (16 + 8 = 24)
}

variable "spoke_subnet_new_bits" {
  description = "Number of additional bits to subnet each Spoke VNet's address space for its default subnet (e.g., 1 for a /25 subnet from a /24 VNet)."
  type        = number
  default     = 1 # Creates /25 subnets from the /24 spoke VNets (24 + 1 = 25)
}

variable "spoke_workload" {
  description = "Specifies the name of the spoke virtual networks resources"
  type        = string
  default     = "spoke"
}

variable "hub_workload" {
  description = "Specifies the name of the central hub VNET resource"
  type        = string
  default     = "infrahub"
}

variable "tags" {
  description = "Specifies the tags to be applied to resources"
  default = {
    Deployment = "Terraform"
    Workload   = "Infrastructure"
    Region     = "UK South"
  }
}