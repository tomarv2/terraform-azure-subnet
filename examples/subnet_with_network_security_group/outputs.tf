output "subnet_id" {
  description = "The subnet ID"
  value       = module.subnet.subnet_id
}

output "subnet_name" {
  description = "The subnet name"
  value       = module.subnet.subnet_name
}

output "virtual_network_name" {
  description = "The name of the virtual network in which the subnet is created in"
  value       = module.subnet.virtual_network_name
}

output "resource_group_name" {
  description = "The name of the resource group in which the subnet is created in"
  value       = module.subnet.resource_group_name
}

output "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  value       = module.subnet.subnet_address_prefixes
}

output "network_security_group_name" {
  description = "Network security group name"
  value       = module.network_security_group.network_security_group_name
}

output "network_security_group_id" {
  description = "Network security group id"
  value       = module.network_security_group.network_security_group_id
}

output "network_security_group_rule" {
  description = "Network security group rule"
  value       = module.network_security_group.network_security_group_rule
}

output "subnet_network_security_group_association_id" {
  description = "Network subnet group assoication id"
  value = azurerm_subnet_network_security_group_association.subnet_association.id
}