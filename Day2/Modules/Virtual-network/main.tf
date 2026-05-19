resource "azurerm_virtual_network" "vnet" {
    name = var.vnetname
    resource_group_name = var.rg
    location = var.location
    address_space = var.address_space_vnet

}

resource "azurerm_subnet" "subnetname" {
    name = var.subnetname
    resource_group_name = var.rg
    address_prefixes = var.address_prefixes_vnet
    virtual_network_name = azurerm_virtual_network.vnet.name
  
}