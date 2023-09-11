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

variable "virtual_network_name" {
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

variable "key_vault_id" {
  type = string
}

variable "container_registry_id" {
  type = string
}

variable "resource_group_id" {
  type = string
}

variable "dns_zone_ids" {
  type = list(any)
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
