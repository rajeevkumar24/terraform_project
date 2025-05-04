

resource "azurerm_resource_group" "examples" {

 
  name     = "${var.environment}-resources"
  location = var.location[1]
  tags = {
    environment =var.environment
  }
   lifecycle {
    create_before_destroy = true
    precondition {
      #prevant_destroy=true,
      condition     =contains(var.allowed_location, var.location)
      error_message = "Please ente a valid location"
    }
  }
}

resource "azurerm_storage_account" "example" {
  #count = length(var.storage_account_name)
  for_each =var.storage_account_name
 #name                     = var.storage_account_name[count.index]
 name                   = each.value

  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.resource_tags["environment"]
    managed_by  = var.resource_tags["managed_by"]
    department  = var.resource_tags["department"]
  }
}