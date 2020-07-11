resource "digitalocean_droplet" "do-instance" {
  image              = var.do_image
  name               = format("do-instance-%s", var.do_region)
  region             = var.do_region
  size               = var.do_size
  ssh_keys           = var.do_ssh_keys
  private_networking = true
  user_data          = <<CMD_EOF
#!/bin/bash
sudo apt update -yqq && sudo apt install -yqq python-minimal
CMD_EOF

  tags = [
    format("do-instance-%s", var.do_region)
  ]
}
