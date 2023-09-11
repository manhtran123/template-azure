variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "default_tags" { 
    type      = map 
}

variable "dns_zone" {
  type        = string
}

variable "dns_zone_name" {
  type        = string
}

variable "parent_dns_zone_resource_group" {
  type        = string
}

variable "parent_dns_zone" {
  type        = string
}

variable "aks_kubelet_identity_object_id" {
  type        = string
}