resource "hcloud_volume" "data" {
   name = "data"
   size = var.volume_size
   automount = "true"
   format = "ext4"
   # delete_protection = "true"
   server_id = hcloud_server.server.id
}

resource "hcloud_server" "server" {
  depends_on  = [ hcloud_floating_ip.primary_ip ]
  name        = var.server_name
  image       = var.image
  server_type = var.server_type
  location    = var.location
  ssh_keys    = var.ssh_keys
  user_data   = templatefile("${path.module}/cloud-init-hetzner.yml", {
    floating_ip = hcloud_floating_ip.primary_ip.ip_address
  })
}

resource "hcloud_floating_ip" "primary_ip" {
  type      = "ipv4"
  delete_protection = "true"
  home_location  = var.location
}

resource "hcloud_floating_ip_assignment" "primary_ip_assignment" {
  floating_ip_id = hcloud_floating_ip.primary_ip.id
  server_id = hcloud_server.server.id
}
