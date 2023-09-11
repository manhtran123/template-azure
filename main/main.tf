module "resource-group" {
  source              = "../modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  default_tags        = var.default_tags
}

module "virtual-network" {
  source              = "../modules/virtual-network"
  resource_group_name = module.resource-group.name
  project_name        = var.project_name
  environment_name    = var.environment_name
  location            = var.location
  default_tags        = var.default_tags
}

module "container-registry" {
  source                 = "../modules/container-registry"
  resource_group_name    = module.resource-group.name
  project_name           = var.project_name
  environment_name       = var.environment_name
  location               = var.location
  default_tags           = var.default_tags
  container_registry_sku = var.container_registry_sku
}

module "key-vault" {
  source              = "../modules/key-vault"
  resource_group_name = module.resource-group.name
  project_name        = var.project_name
  environment_name    = var.environment_name
  location            = var.location
  default_tags        = var.default_tags
  kv_sku_name         = var.kv_sku_name
}

module "aks" {
  source                     = "../modules/aks"
  resource_group_name        = module.resource-group.name
  project_name               = var.project_name
  environment_name           = var.environment_name
  location                   = var.location
  default_tags               = var.default_tags
  tenant_id                  = var.tenant_id
  virtual_network_name       = module.virtual-network.name
  kubernetes_version         = var.kubernetes_version
  kuberenetes_vm_size        = var.kuberenetes_vm_size
  kuberenetes_node_count     = var.kuberenetes_node_count
  kuberenetes_network_plugin = var.kuberenetes_network_plugin
  kuberenetes_network_policy = var.kuberenetes_network_policy
  kuberenetes_auto_scaling   = var.kuberenetes_auto_scaling
  kuberenetes_min_count      = var.kuberenetes_min_count
  kuberenetes_max_count      = var.kuberenetes_max_count
  load_balancer_sku          = var.load_balancer_sku
  container_registry_id      = module.container-registry.id
  resource_group_id          = module.resource-group.id
  dns_zone_ids               = module.dns_zones[*].id
  key_vault_id               = module.key-vault.id
  extra_nodepool_count       = var.extra_nodepool_count
  extra_nodepool_vm_size     = var.extra_nodepool_vm_size
  extra_nodepool_node_count  = var.extra_nodepool_node_count
  extra_nodepool_mode        = var.extra_nodepool_mode
}

# module "cosmos-db" {
#   source                    = "../modules/cosmos-db"
#   resource_group_name       = module.resource-group.name
#   project_name              = var.project_name
#   environment_name          = var.environment_name
#   location                  = var.location
#   default_tags              = var.default_tags
#   cosmosdb_total_throughput_limit = var.cosmosdb_total_throughput_limit
# }

module "redis-cache" {
  source              = "../modules/redis-cache"
  resource_group_name = module.resource-group.name
  project_name        = var.project_name
  environment_name    = var.environment_name
  location            = var.location
  default_tags        = var.default_tags
  redis_capacity      = var.redis_capacity
  redis_family        = var.redis_family
  redis_sku_name      = var.redis_sku_name
}

module "servicebus" {
  source              = "../modules/servicebus"
  resource_group_name = module.resource-group.name
  project_name        = var.project_name
  environment_name    = var.environment_name
  location            = var.location
  default_tags        = var.default_tags
  service_bus_sku     = var.service_bus_sku
}

module "private_blob_dns_zone" {
  source              = "../modules/private-dns-zone"
  resource_group_name = module.resource-group.name
  default_tags        = var.default_tags
  virtual_network_id  = module.virtual-network.id
  private_zone_name   = var.private_blob_zone_name
  network_link_name   = var.blob_network_link_name
}

module "storage" {
  source                   = "../modules/storage"
  resource_group_name      = module.resource-group.name
  project_name             = var.project_name
  environment_name         = var.environment_name
  location                 = var.location
  default_tags             = var.default_tags
  account_tier             = var.account_tier
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  account_access_tier      = var.account_access_tier
}

module "storage_blob_private_endpoint" {
  source = "../modules/private-endpoint"

  resource_group_name = module.resource-group.name
  location            = var.location
  default_tags        = var.default_tags
  name                = module.storage.storage_account_name

  subnet_id                        = module.virtual-network.svc_snet2_id
  private_link_enabled_resource_id = module.storage.storage_account_id
  private_dns_zone_name            = module.private_blob_dns_zone.name

  # you can add other subresouce also
  subresource_names = ["blob"]
}

module "dns_zones" {
  count                          = length(var.dns_zones)
  source                         = "../modules/dns-child-zone"
  resource_group_name            = module.resource-group.name
  location                       = var.location
  default_tags                   = var.default_tags
  dns_zone                       = var.dns_zones[count.index].dns_zone
  dns_zone_name                  = var.dns_zones[count.index].dns_zone_name
  parent_dns_zone_resource_group = var.dns_zones[count.index].parent_dns_zone_resource_group
  parent_dns_zone                = var.dns_zones[count.index].parent_dns_zone
  aks_kubelet_identity_object_id = module.aks.cluster_kubelet_identity_object_id
}
