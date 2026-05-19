variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
  default = "eastasia"
}


variable "account_tier" {
    default = "Standard"
}

variable "account_replication_type" {
    default = "LRS"
}

variable "storage-name" {
    default = "storagepvtend001"
}

variable "user_assigned_identity_id" {
    type = string
  
}

variable "containername" {
    default = "blobcontainertxt"
  
}