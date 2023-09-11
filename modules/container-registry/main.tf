resource "azurerm_container_registry" "acr" {
  name                = "cr${var.project_name}${var.environment_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.container_registry_sku
  admin_enabled       = true
  tags                = var.default_tags
}
