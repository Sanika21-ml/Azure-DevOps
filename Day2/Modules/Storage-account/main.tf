resource "azurerm_storage_account" "storage" {
    name = var.storage-name
    resource_group_name = var.rg
    location = var.location
    account_replication_type = var.account_replication_type
    account_tier = var.account_tier

    identity {
      type = "UserAssigned"
      identity_ids = [ var.user_assigned_identity_id ]    
    }

}

resource "azurerm_storage_container" "example" {
  name                  = var.containername
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}