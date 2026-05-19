resource "azurerm_user_assigned_identity" "user_identity" {
  location = var.location
  name = var.user
  resource_group_name = var.rg
}