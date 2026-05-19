variable "resource_group" {
    default = "rg-tf-git-01"
  
}

variable "location" {
    default = "centralindia"
  
}

variable "storage" {
    description = "storage account name"
    default = "storageaccountgit001"
  
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