variable "prefix" {
  default = "day17"
  type = string
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "Central India"
}

resource "azurerm_service_plan" "asp" {
    name                = "${var.prefix}-asp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
   os_type = "Linux"
   sku_name = "S1"     
  
}

resource "azurerm_linux_web_app" "webappservice" {
    name                = "${var.prefix}-webapp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.asp.id
    app_settings = {
        "WEBSITES_PORT" = "80"
    }
    site_config {
       
    }
  
}

resource "azurerm_linux_web_app_slot" "slot1" {
    name                = "${var.prefix}-slot1"
    app_service_id = azurerm_linux_web_app.webappservice.id

    site_config {
      
    }
   
  
}
