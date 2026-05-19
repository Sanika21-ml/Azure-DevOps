variable "resource_group" {
    type = string
    default = "rg-tf-git-01"
  
}

variable "location" {
    default = "eastus"
  
}

variable "function-name" {
    default = "function-app-001"
  
}

variable "storage_name" {
    type = string
  
}

variable "storage_primary_access" {
    type = string
}

variable "app_service_id" {
    type = string
  
}