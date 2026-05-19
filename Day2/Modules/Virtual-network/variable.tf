variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
   default = "centralindia"
}

variable "vnetname" {
   default = "network"
}

variable "address_space_vnet" {
    default = [ "10.0.0.0/16" ]
}

variable "subnetname" {
    default = "subnet-1"
  
}

variable "address_prefixes_vnet" {
    default = ["10.0.0.0/24"]
  
}