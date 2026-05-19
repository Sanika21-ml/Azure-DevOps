
resource "azurerm_storage_account" "storage" {
    name = var.storage
    resource_group_name = var.resource_group
    location = var.location
    account_tier = var.storage_account_tier
    account_replication_type = var.storage_replication_type
  
}