resource "azurerm_cosmosdb_account" "cosmos" {
  name                = "cosmos-${var.project_name}-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"

  capacity {
    total_throughput_limit  = 4000
  }

  capabilities {
    name              = "EnableMongo"
  }
  
  capabilities {
    name              = "DisableRateLimitingResponses"
  }

  capabilities {
    name              = "mongoEnableDocLevelTTL"
  }

  mongo_server_version      = "4.0"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location                = var.location
    failover_priority       = 0
  }

  tags                      = var.default_tags
}
