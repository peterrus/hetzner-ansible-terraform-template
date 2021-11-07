# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
  type = string
  description = "Hetzner API token for project (r/w access)"
}

variable "location" {
  type = string
  description = "Server location, use 'hcloud location list' to get a list of valid choices"
}

variable "server_name" {
  type = string
  description = "Friendly name for server"
}

variable "image" {
  type = string
  description = "OS image used for server, use 'hcloud image list' to get a list of valid choices"
  default = "ubuntu-20.04"
}

variable "server_type" {
  type = string
  description = "Server type of created server, use 'hcloud server-type list' to get a list of valid choices"
}

variable "ssh_keys" {
  type = list(string)
  description = "Which SSH keys will be able to authenticate to the server once it is booted. use 'hcloud ssh-key list' to get the id's of keys that are already registered to this project"
}

variable "volume_size" {
  type = string
  description = "Size in GB of the persistent data volume that will be kept separate from the servers lifecycle"
}
