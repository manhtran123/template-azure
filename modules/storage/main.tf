resource "azurerm_storage_account" "storage" {
  name                             = "st${var.project_name}${var.environment_name}001"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  account_tier                     = var.account_tier
  account_kind                     = var.account_kind
  account_replication_type         = var.account_replication_type
  enable_https_traffic_only        = true
  access_tier                      = var.account_access_tier
  cross_tenant_replication_enabled = true
  tags                             = var.default_tags
}


