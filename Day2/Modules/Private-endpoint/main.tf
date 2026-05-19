resource "azurerm_private_dns_zone" "dnsname" {
    name = "privatefile.blob.core.windows.net"
    resource_group_name = var.rg
}

resource "azurerm_private_endpoint" "private" {
    name = var.private
    subnet_id = var.subnet_id
    resource_group_name = var.rg
    location = var.location

    private_service_connection  {
      name = var.connect
      private_connection_resource_id = var.storage_id
      subresource_names = [ "blob" ]
      is_manual_connection = false
}
    private_dns_zone_group {
        name = var.dnsname
        private_dns_zone_ids = [ azurerm_private_dns_zone.dnsname.id ]
    }
  
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
    name = var.vnetlink 
    resource_group_name = var.rg
    private_dns_zone_name = azurerm_private_dns_zone.dnsname.name
    virtual_network_id = var.vnet_id
  
}