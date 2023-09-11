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

variable "redis_capacity" { 
    type      = number 
}

variable "redis_family" { 
    type      = string 
}

variable "redis_sku_name" { 
    type      = string 
}