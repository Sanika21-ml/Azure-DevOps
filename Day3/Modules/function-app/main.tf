resource "azurerm_linux_function_app" "function" {
    name = var.function-name
    resource_group_name = var.resource_group
    location = var.location
    service_plan_id = var.app_service_id
    storage_account_name = var.storage_name
    storage_account_access_key = var.storage_primary_access
    site_config {
      
    }
}