variable "resource_group_name" {
  type        = string
}

variable "project_name" {
  type        = string
}

variable "environment_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "default_tags" { 
    type      = map 
}

variable "container_registry_sku" { 
    type      = string 
}