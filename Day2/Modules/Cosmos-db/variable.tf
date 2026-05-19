variable "db_account_name" {
  type    = string
  default = "cosmosdbtestacc011"
}

variable "rg" {
   default = "rg-Dev-01"
}

variable "location" {
   default = "centralindia"
} 

variable "public_network" {
  type    = bool
  default = false
}

variable "database_name" {
  type    = string
  default = "appdb-test"
}

variable "db_container_name" {
  type    = string
  default = "itemsdb"
}