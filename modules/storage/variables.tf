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

variable "account_tier" { 
    type      = string 
}

variable "account_kind" { 
    type      = string 
}

variable "account_replication_type" { 
    type      = string 
}

variable "account_access_tier" { 
    type      = string 
}