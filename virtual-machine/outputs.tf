# Outputs
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "tls_private_key" {
  value     = tls_private_key.secureadmin_ssh.private_key_pem
  sensitive = true
}

output "public_ips" {
  value = [for ip in azurerm_public_ip.my_terraform_public_ip : ip.ip_address]
}

output "load_balancer_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}