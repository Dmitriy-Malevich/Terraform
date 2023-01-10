terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


data "digitalocean_ssh_key" "Ansible-master-key" {
  name = "Ansible-master-key"
}
