module "resource" {
    source = "../../Modules/Resource-group"
    rg = var.rg
    location = var.location
}



module "storage" {
    source = "../../Modules/Storage-account"
    storage-name = var.storage-name
    user_assigned_identity_id = module.user-identity.user_assigned_identity_id
    rg = module.resource 
  
}

module "storage-account-web" {
    source = "../../Modules/Storage-account"
    storage-name = var.storage-name
    user_assigned_identity_id = module.user-identity.user_assigned_identity_id
    location = "westus"

    depends_on = [ module.resource ]
  
}

module "vnet" {
    source = "../../Modules/Virtual-network"
    vnetname = var.vnetname
    subnetname = var.subnetname
    
    depends_on = [ module.resource ]
}

module "function" {
    source = "../../Modules/Function-app"
    function-name = var.function-name
    appplan-name = var.appplan-name
    storage_name = module.storage.storage_name
    storage_primary_access = module.storage.storage_primary_access
    user_assigned_identity_id = module.user-identity.user_assigned_identity_id

    depends_on = [ module.resource, module.storage ]
  
}

module "keyvault" {
    source = "../../Modules/Key-vault"
    key-name = var.key-name
}

module "private-endpoint" {
    source = "../../Modules/Private-endpoint"
    vnet_id = module.vnet.vnet_id
    subnet_id = module.vnet.subnet_id
    storage_id = module.storage.storage_id
  
}

module "user-identity" {
    source = "../../Modules/Managed-Identity"
  
}

module "cosmosdb" {
    source = "../../Modules/Cosmos-db"
  
}

module "role-assignment" {
    source = "../../Modules/Role-assignment"
    principal_id = module.user-identity.principal_id
  
}