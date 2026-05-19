variable "resource_group" {
    default = "rg-tf-git-01"
  
}

variable "location" {
    default = "eastus"
  
}

variable "storage" {
    description = "storage account name"
    default = "backendstatefilegit"
  
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}