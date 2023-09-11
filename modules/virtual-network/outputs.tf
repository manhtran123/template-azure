output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "svc_snet2_id" {
  value = azurerm_subnet.subnet2.id
}

output "svc_snet2_name" {
  value = azurerm_subnet.subnet2.name
}

output "svc_snet3_id" {
  value = azurerm_subnet.subnet3.id
}

output "svc_snet3_name" {
  value = azurerm_subnet.subnet3.name
}