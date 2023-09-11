variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "location" {
  type = string
}

variable "default_tags" {
  type = map(any)
}

variable "tenant_id" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "kuberenetes_vm_size" {
  type = string
}

variable "kuberenetes_node_count" {
  type = number
}

variable "kuberenetes_network_plugin" {
  type = string
}

variable "kuberenetes_network_policy" {
  type = string
}

variable "kuberenetes_auto_scaling" {
  type = bool
}

variable "kuberenetes_min_count" {
  type = number
}

variable "kuberenetes_max_count" {
  type = number
}

variable "load_balancer_sku" {
  type = string
}

variable "extra_nodepool_count" {
  type = number
}

variable "extra_nodepool_vm_size" {
  type = string
}

variable "extra_nodepool_node_count" {
  type = number
}

variable "extra_nodepool_mode" {
  type = string
}

variable "container_registry_sku" {
  type = string
}

variable "cosmosdb_total_throughput_limit" {
  type = number
}

variable "redis_capacity" {
  type = number
}

variable "redis_family" {
  type = string
}

variable "redis_sku_name" {
  type = string
}

variable "service_bus_sku" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "account_access_tier" {
  type = string
}

variable "kv_sku_name" {
  type = string
}

variable "dns_zones" {
  type = list(any)
}

variable "private_blob_zone_name" {
  type = string

}
variable "blob_network_link_name" {
  type = string
}
