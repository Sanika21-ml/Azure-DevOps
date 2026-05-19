module "resource-group" {
    source = "./Modules/resource-group"
    resource_group = var.resource_group
    location = var.location 
  
}

module "storage_account" {
    source = "./Modules/storage-account"

    depends_on = [ module.resource-group ]

  
}

module "app-service" {
    source = "./Modules/app-service"

    depends_on = [ module.resource-group ]

  
}

module "function-app" {
    source = "./Modules/function-app"
    storage_name = module.storage_account.storage_name
    storage_primary_access = module.storage_account.storage_primary_access

    depends_on = [ module.resource-group,module.app-service ]    
    
  
}