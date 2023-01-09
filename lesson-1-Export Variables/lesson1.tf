resource "digitalocean_tag" "foobar" {
  name = "foobar"
}

resource "digitalocean_droplet" "example" {
  count = 2
  image = "ubuntu-20-04-x64"
  name = "example-1"
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
