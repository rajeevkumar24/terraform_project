terraform {
    required_providers {
      azurerm={
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
      }
    }
  required_version = ">=1.9.0"
}

provider "azurerm" {
    features {}
      subscription_id = "XXXXX"
    
  
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "techrajeev101"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}