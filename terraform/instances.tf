resource "digitalocean_droplet" "do-registry-instance" {
  image              = var.do_image
  name               = format("do-registry-instance-%s", var.do_region)
  region             = var.do_region
  size               = var.do_size
  ssh_keys           = var.do_ssh_keys
  private_networking = true
  user_data          = file(format("%s/scripts/user_data.sh", path.module))

  tags = [
    format("do-registry-instance-%s", var.do_region)
  ]
}

resource "digitalocean_droplet" "do-kubernetes-master-instance" {
  count              = var.do_kubernetes_master_count
  image              = var.do_image
  name               = format("do-kubernetes-master-instance-%d-%s", count.index, var.do_region)
  region             = var.do_region
  size               = var.do_size
  ssh_keys           = var.do_ssh_keys
  private_networking = true
  user_data          = file(format("%s/scripts/user_data.sh", path.module))

  tags = [
    format("do-kubernetes-master-instance-%d-%s", count.index, var.do_region),
  ]
}

resource "digitalocean_droplet" "do-kubernetes-node-instance" {
  count              = var.do_kubernetes_node_count
  image              = var.do_image
  name               = format("do-kubernetes-node-instance-%d-%s", count.index, var.do_region)
  region             = var.do_region
  size               = var.do_size
  ssh_keys           = var.do_ssh_keys
  private_networking = true
  user_data          = file(format("%s/scripts/user_data.sh", path.module))

  tags = [
    format("do-kubernetes-node-instance-%d-%s", count.index, var.do_region),
  ]
}
