variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
   default = "centralindia"
}

variable "appplan-name" {
    default = "function-plan-01"
  
}

variable "function-name" {
    default = "blobfunction-01"
  
}

variable "storage_name" {
    type = string
  
}

variable "storage_primary_access" {
    type = string
  
}


variable "user_assigned_identity_id" {
    type = string
  
}