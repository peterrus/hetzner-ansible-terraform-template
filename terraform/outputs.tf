output "server_ip" {
  value = hcloud_floating_ip.primary_ip.ip_address
}
