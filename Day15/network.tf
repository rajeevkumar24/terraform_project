
resource azurerm_resource_group "rg" {
  name     = "rg-peer"
  location = "East US"
}
resource azurerm_virtual_network "vnet1" {
  name                = "peer1-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"] # Add the address space here
  }

  resource "azurerm_subnet" "sn1" {
    name = "peer1-subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes =         ["10.0.0.0/24"]
    
  }

  resource azurerm_virtual_network "vnet2" {
  name                = "peer2-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"] # Add the address space here
  }

  resource "azurerm_subnet" "sn2" {
    name = "peer2-subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes =         ["10.1.0.0/24"]
    
  }

  resource azurerm_virtual_network_peering "peer1-peer2" {
    name                         = "peer1-peer2"
    resource_group_name          = azurerm_resource_group.rg.name
    virtual_network_name         = azurerm_virtual_network.vnet1.name
    remote_virtual_network_id    = azurerm_virtual_network.vnet2.id
    allow_virtual_network_access = true
    allow_forwarded_traffic       = true

    # This block is only needed if you are peering across subscriptions
  }
