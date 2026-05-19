resource "azurerm_service_plan" "plan" {
  name                = var.appplan
  location            = var.location
  resource_group_name = var.resource_group
  os_type = "Linux"
  sku_name = "F1"

}

resource "azurerm_windows_web_app" "as" {
    resource_group_name = var.resource_group
    location = var.location
    name =var.webappname
    service_plan_id = azurerm_service_plan.plan.id
    site_config {
         always_on = false
    }
  
}