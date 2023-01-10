resource "digitalocean_tag" "foobar" {
  name = "foobar"
}

resource "digitalocean_droplet" "example-1" {
  image = "ubuntu-20-04-x64"
  name = "example-11"
  region = "nyc3"
  size = "s-1vcpu-1gb-amd"
  ssh_keys = [
    data.digitalocean_ssh_key.Ansible-master-key.id
  ]
  tags   = [digitalocean_tag.foobar.id]


 connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file("~/.ssh/id_rsa")      
    timeout = "2m"
  }

  provisioner "remote-exec" {
#    inline = [
#      "export PATH=$PATH:/usr/bin",
#      # install nginx
#      "sudo apt update",
#      "sudo apt install -y nginx"
#    ]
    script = "script-html.sh"
  }
}

resource "digitalocean_droplet" "example-2" {
  image = "ubuntu-20-04-x64"
  name = "example-22"
  region = "nyc3"
  size = "s-1vcpu-1gb-amd"
  ssh_keys = [
    data.digitalocean_ssh_key.Ansible-master-key.id
  ]
  tags   = [digitalocean_tag.foobar.id]

connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file("~/.ssh/id_rsa")
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}

resource "digitalocean_loadbalancer" "example-1b" {
  name = "www-example"
  region = "nyc3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  healthcheck {
    port = 22
    protocol = "tcp"
  }

  droplet_ids = [digitalocean_droplet.example-1.id, digitalocean_droplet.example-2.id ]
}

