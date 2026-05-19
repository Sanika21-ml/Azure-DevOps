output "user_assigned_identity_id" {
    value = azurerm_user_assigned_identity.user_identity.id
  
}

output "principal_id" {
    value = azurerm_user_assigned_identity.user_identity.principal_id
  
}