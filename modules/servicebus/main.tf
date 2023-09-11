resource "azurerm_servicebus_namespace" "sb" {
  name                = "sb-${var.project_name}-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.service_bus_sku
  local_auth_enabled  = true
  tags                = var.default_tags
}

# resource "azurerm_servicebus_namespace_authorization_rule" "sb" {
#   name                = "sbr-${var.project_name}-${var.environment_name}"
#   namespace_id        = azurerm_servicebus_namespace.sb.id
#   send                = true
#   listen              = true
#   manage              = true
# }

# resource "azurerm_servicebus_queue" "sb" {
#   name                = "sbq-${var.project_name}-${var.environment_name}"
#   namespace_id        = azurerm_servicebus_namespace.sb.id
#   enable_partitioning = true
# }

# resource "azurerm_servicebus_topic" "sb" {
#   name                = "sbt-${var.project_name}-${var.environment_name}"
#   namespace_id        = azurerm_servicebus_namespace.sb.id
#   enable_partitioning = true
# }

# resource "azurerm_servicebus_subscription" "sb" {
#   name                = "sbs-${var.project_name}-${var.environment_name}"
#   topic_id            = azurerm_servicebus_topic.sb.id
#   max_delivery_count  = 5
#   dead_lettering_on_filter_evaluation_error = false
#   dead_lettering_on_message_expiration = true
#   enable_batched_operations = true
# }

# resource "azurerm_servicebus_subscription_rule" "sb" {
#   name            = "sbsr-${var.project_name}-${var.environment_name}"
#   subscription_id = azurerm_servicebus_subscription.sb.id
#   filter_type     = "CorrelationFilter"

#   correlation_filter {
#     correlation_id = "high"
#     label          = "red"
#     properties = {
#       customProperty = "value"
#     }
#   }
# }y
