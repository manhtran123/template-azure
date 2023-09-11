
resource "azurerm_private_endpoint" "endpoint" {
  # name                = format("%s-%s", var.name, "private-endpoint")
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    # name                           = format("%s-%s", var.name, "privateserviceconnection")
    name                           = var.name
    private_connection_resource_id = var.private_link_enabled_resource_id
    is_manual_connection           = false
    subresource_names              = var.subresource_names
  }
  tags = var.default_tags
}

resource "azurerm_private_dns_a_record" "dns_a" {
  # name                = format("%s-%s", var.name, "arecord")
  name                = var.name
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address]
  tags                = var.default_tags
}
