resource "azurerm_private_dns_zone" "zone" {
  name                = var.private_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.default_tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      number_of_record_sets
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = var.network_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = var.virtual_network_id
  tags                  = var.default_tags
}
