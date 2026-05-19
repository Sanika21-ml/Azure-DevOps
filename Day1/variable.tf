variable "rg" {
    default = "Test-rg-azure-devops"
  
}

variable "location" {
    default = "centralindia"
  
}

variable "vnetname" {
    default = "network-test"
  
}

variable "subnetname" {
    default = "subnet"
  
}

variable "vmname" {
    description = "virtual machine name"
    default = "machine2"
  
}

variable "admin_username" {
    description = "username"
    default = "azureuser"
  
}

variable "admin_password" {
    description = "password for vm"
    default = "password@1234"
  
}

variable "vm_size" {
    description = "size of vm"
    default = "Standard_B2ats_v2"
  
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

