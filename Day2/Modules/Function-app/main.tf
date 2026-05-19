resource "azurerm_service_plan" "plan" {
  name                = var.appplan-name
  location            = var.location
  resource_group_name = var.rg
  os_type = "Linux"
  sku_name = "Y1"

}


resource "azurerm_linux_function_app" "function" {
    name = var.function-name
    resource_group_name = var.rg
    location = var.location
    service_plan_id = azurerm_service_plan.plan.id
    storage_account_name = var.storage_name
    storage_account_access_key = var.storage_primary_access
    site_config {
      
    }

    identity {
      type = "UserAssigned"
      identity_ids = [ var.user_assigned_identity_id ]
    }
}
