resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}-${var.environment_name}-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]
  tags                = var.default_tags
}

resource "azurerm_subnet" "subnet2" {
  name                                           = "snet-${var.environment_name}-${var.location}-002"
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = ["10.220.0.0/16"]
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = []
}

resource "azurerm_subnet" "subnet3" {
  name                 = "snet-${var.environment_name}-${var.location}-003"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.210.0.0/16"]
  service_endpoints    = []
}
