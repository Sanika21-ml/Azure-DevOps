resource "azurerm_service_plan" "asp" {
  name                = var.func_app_plan
  location            = var.location
  resource_group_name = var.resource_group
  os_type = "Linux"
  sku_name = "Y1"

}

resource "azurerm_linux_function_app" "function" {
    name = var.function-name
    resource_group_name = var.resource_group
    location = var.location
    service_plan_id = azurerm_service_plan.asp.id
    storage_account_name = var.storage_name
    storage_account_access_key = var.storage_primary_access
    site_config {
      
    }
}