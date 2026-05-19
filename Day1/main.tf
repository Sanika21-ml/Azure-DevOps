resource "azurerm_resource_group" "rg" {
    name = var.rg
    location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name = var.vnetname
    resource_group_name = var.rg
    location = var.location
    address_space = ["10.0.0.0/16" ]
}

resource "azurerm_subnet" "subnet" {
    name = var.subnetname
    resource_group_name = var.rg
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ "10.0.0.0/24" ]
}

resource "azurerm_storage_account" "storage" {
    name = var.storage
    resource_group_name = var.rg
    location = var.location
    account_tier = var.storage_account_tier
    account_replication_type = var.storage_replication_type
  
}


resource "azurerm_network_interface" "this" {
  name = "${var.vmname}-nic"
  location = var.location
  resource_group_name = var.rg

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "this" {
  name = var.vmname
  resource_group_name = var.rg
  location = var.location
  size = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_private_dns_zone" "dnsname" {
    name = "privatefile.blob.core.windows.net"
    resource_group_name = var.rg
}

resource "azurerm_private_endpoint" "private" {
    name = var.private
    subnet_id = azurerm_subnet.subnet.id
    resource_group_name = var.rg
    location = var.location

    private_service_connection  {
      name = var.connect
      private_connection_resource_id = azurerm_storage_account.storage.id
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
    virtual_network_id = azurerm_virtual_network.vnet.id
  
}