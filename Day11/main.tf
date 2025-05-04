
locals {
  formatted_name = lower(replace(var.project_name, " ", "-"))
  formatted_tags = merge(var.default_tags, var.environment_tags)
  storage_account_name = trim(lower(substr(var.storage_account_name, 0, 23)),"!%^&*()_+")
  formatted_ports = split(",", var.allowed_ports)
  fornsg_rules=[for port in local.formatted_ports: 
  {
    name= "port-${port}"
    port= port
    description= "Allow traffic on port ${port}"
  }]

  vm_sizes = lookup(var.vm_sizes,var.environment,lower("dev"))
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.formatted_name}-rg"
  location = "West Europe"
  tags = local.formatted_tags
}

resource "azurerm_storage_account" "sg1" {
 
 name                   = local.storage_account_name 
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags =  local.formatted_tags
}
resource "azurerm_network_security_group" "ng1" {
  name                = "${local.formatted_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.destination_port_range
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}

output "rgname" {
  value = azurerm_resource_group.rg.name
  
}

output "tags" {
  value = azurerm_resource_group.rg.tags
  
}

output "name" {
  value = azurerm_storage_account.sg1.name
  
}

output "nsg-rules" {
  value = local.fornsg_rules
}

output "security_name" {
  value = azurerm_network_security_group.ng1.name
}
output "vm_sizes" {
  value = local.vm_sizes
  
}