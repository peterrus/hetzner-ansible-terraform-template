# This resource generates a inventory file for ansible that contains the server we
# have created through ansible and sets an alias to that server by it's primary ipv4
# address. This is not the same address as the floating ip. We are using this address
# instead of the floating ip to prevent ssh signature mismatches when the server gets
# rebuilt.
resource "local_file" "ansible_inventory" {
  content = templatefile("ansible-inventory.yml.tmpl", {
    hosts = tomap({
      server = tomap({
        ipv4_address = hcloud_server.server.ipv4_address
        data_volume_path = hcloud_volume.data.linux_device
      })
    })
  })
  filename = format("%s/%s", abspath(path.root), "../ansible/inventory.yml")
}
