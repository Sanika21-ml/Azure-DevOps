variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
   default = "centralindia"
} 


variable "storage-name" {
    default = "storagepvtend001"
}

variable "vnetname" {
   default = "network"
}

variable "subnetname" {
    default = "subnet-1"
  
}

variable "appplan-name" {
    default = "function-plan-01"
  
}

variable "function-name" {
    default = "blobfunction-01"
  
}

variable "key-name" {
    default = "secretkey-01"
  
}
