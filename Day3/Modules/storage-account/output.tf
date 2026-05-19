output "storage_name" {
    value = azurerm_storage_account.storage.name
  
}

output "storage_primary_access" {
    value = azurerm_storage_account.storage.primary_access_key
  
}