output "server_floating_ip" {
  value = hcloud_floating_ip.primary_ip.ip_address
}

output "server_ip" {
  value = hcloud_server.server.ipv4_address
}
