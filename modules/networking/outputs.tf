output "virtual_network" {
  value=azurerm_virtual_network.network
}

output "subnets" {
  value=azurerm_subnet.subnets
}