output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}
output "client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
}
output "cluster_kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
}
