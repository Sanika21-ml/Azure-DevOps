variable "resource_group" {
    type = string
    default = "rg-tf-git-01"
  
}

variable "location" {
    default = "centralindia"
  
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

variable "func_app_plan" {
    default = "func_appplanservice"
  
}