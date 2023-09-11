data "azurerm_dns_zone" "parent" {
  name                = var.parent_dns_zone
  resource_group_name = var.parent_dns_zone_resource_group
}

resource "azurerm_dns_zone" "child" {
  name                = var.dns_zone
  resource_group_name = var.parent_dns_zone_resource_group
  tags                = var.default_tags
}

resource "azurerm_dns_ns_record" "parent_child_ns" {
  name                = var.dns_zone_name
  zone_name           = data.azurerm_dns_zone.parent.name
  resource_group_name = data.azurerm_dns_zone.parent.resource_group_name
  ttl                 = 3600

  records             = azurerm_dns_zone.child.name_servers

  tags                = var.default_tags
}

resource "azurerm_role_assignment" "dns_zone_aks_network_role" {
  principal_id                     = var.aks_kubelet_identity_object_id
  role_definition_name             = "DNS Zone Contributor"
  scope                            = azurerm_dns_zone.child.id
  skip_service_principal_aad_check = true
}