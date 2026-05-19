variable "subnet_id" {
    type = string
  
}

variable "storage_id" {
    type = string
  
}

variable "vnet_id" {
    type = string
  
}

variable "private" {
    description = "name of private endpoints"
    default = "storage-endpoint-demo"
}

variable "connect" {
    default = "first-private-connection1"
    description = "private connection name"
}

variable "dnsname" {
    default = "demo-dns"
  
}

variable "vnetlink" {
    default = "dnslink"
  
}

variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
   default = "centralindia"
}