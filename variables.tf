# variables
variable "resource_group" {
  type        = string
  description = "name of resource group"
  default     = "devlab-priendpt-rg"
}

variable "location" {
  type        = string
  description = "name of location"
  default     = "East US2"
}

variable "virtual_network" {
  type        = string
  description = "name of virtual network"
  default     = "devlab-vnet"
}

variable "subnet" {
  type        = string
  description = "name of subnetwork"
  default     = "dev-db-subnet"
}

variable "private_dns_zone" {
  type        = string
  description = "name of private dns zone"
  default     = "privatelink.mysql.database.azure.com"
}

variable "network_sec_group" {
  type        = string
  description = "name of network security group"
  default     = "dev-db-nsg"
}


