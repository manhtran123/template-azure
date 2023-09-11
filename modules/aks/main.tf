resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.environment_name}-${var.location}-001"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.240.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-${var.environment_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.project_name}-${var.environment_name}"
  kubernetes_version  = var.kubernetes_version

  oidc_issuer_enabled = true

  default_node_pool {
    name           = "agentpool"
    node_count     = var.kuberenetes_node_count
    vm_size        = var.kuberenetes_vm_size
    vnet_subnet_id = azurerm_subnet.subnet.id
    type           = "VirtualMachineScaleSets"
    max_pods       = 250

    enable_auto_scaling = var.kuberenetes_auto_scaling
    min_count           = var.kuberenetes_min_count
    max_count           = var.kuberenetes_max_count
  }

  network_profile {
    network_plugin    = var.kuberenetes_network_plugin
    network_policy    = var.kuberenetes_network_policy
    load_balancer_sku = var.load_balancer_sku
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.default_tags
}

resource "azurerm_role_assignment" "role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.container_registry_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "dns_role" {
  count                            = length(var.dns_zone_ids)
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "Contributor"
  scope                            = var.dns_zone_ids[count.index]
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "rg_role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "Reader"
  scope                            = var.resource_group_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "network_role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "Network Contributor"
  scope                            = var.resource_group_id
  skip_service_principal_aad_check = true
}

resource "azurerm_key_vault_access_policy" "kv1_access" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  key_permissions = [
    "Get", "List",
  ]

  secret_permissions = [
    "Get", "List",
  ]

  certificate_permissions = [
    "Get", "List",
  ]

  storage_permissions = []
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count                 = var.extra_nodepool_count
  name                  = "agentpool${count.index}"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.extra_nodepool_vm_size
  node_count            = var.extra_nodepool_node_count
  mode                  = var.extra_nodepool_mode
  vnet_subnet_id        = azurerm_subnet.subnet.id
  node_taints           = []
  zones                 = []
  tags                  = var.default_tags
}

# resource "azurerm_public_ip" "ingress_ip" {
#   name                = "aks-${var.project_name}-${var.environment_name}-ing-ip"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
#   tags                = var.default_tags
#   lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }
# }
