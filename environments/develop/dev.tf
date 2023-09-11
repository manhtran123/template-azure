terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-iac"
    storage_account_name = "stiac001"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

module "main" {
  source           = "../../main"
  subscription_id  = "47d89319-220b-4042-8df3-f02fd3613779"
  project_name     = "crossborder"
  environment_name = "dev"
  default_tags = {
    project = "crossborder"
    env     = "dev"
  }
  resource_group_name        = "rg-crossborder-dev"
  tenant_id                  = "337b60c0-474f-411b-b85f-e72e85b7c17c"
  location                   = "southeastasia"
  kubernetes_version         = "1.21.9"
  kuberenetes_vm_size        = "Standard_B2ms"
  kuberenetes_node_count     = 2
  kuberenetes_network_plugin = "azure"
  kuberenetes_network_policy = "calico"
  load_balancer_sku          = "standard"
  container_registry_sku     = "Basic"
  kuberenetes_auto_scaling   = true
  kuberenetes_min_count      = 2
  kuberenetes_max_count      = 3
  extra_nodepool_count       = 0
  extra_nodepool_vm_size     = "Standard_B2s"
  extra_nodepool_node_count  = 1
  extra_nodepool_mode        = "User"

  cosmosdb_total_throughput_limit = 4000

  redis_capacity = 0
  redis_family   = "C"
  redis_sku_name = "Basic"

  service_bus_sku = "Standard"

  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_access_tier      = "Hot"

  kv_sku_name = "standard"

  dns_zones = [
    {
      dns_zone                       = "dev.aionbyte.com"
      dns_zone_name                  = "dev"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "aionbyte.com"
    },
    {
      dns_zone                       = "dev.e2way.co"
      dns_zone_name                  = "dev"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "e2way.co"
    },
    {
      dns_zone                       = "api-dev.aionbyte.com"
      dns_zone_name                  = "api-dev"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "aionbyte.com"
    },
    {
      dns_zone                       = "web-dev.aionbyte.com"
      dns_zone_name                  = "web-dev"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "aionbyte.com"
    },
    {
      dns_zone                       = "devzone.e2way.co"
      dns_zone_name                  = "devzone"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "e2way.co"
    },
    {
      dns_zone                       = "devshop.e2way.co"
      dns_zone_name                  = "devshop"
      parent_dns_zone_resource_group = "rg-crossborder-shared-001"
      parent_dns_zone                = "e2way.co"
    },
  ]

  private_blob_zone_name = "privatelink.blob.core.windows.net"
  blob_network_link_name = "vnet-001-link"
}
