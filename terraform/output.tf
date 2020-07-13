output "do-registry-instance-ipv4-address" {
  value       = digitalocean_droplet.do-registry-instance.ipv4_address
  description = "Registry instance IPv4 address"
}

output "do-registry-domain-name" {
  value       = digitalocean_domain.do-registry-domain.name
  description = "Registry domain name"
}

output "do-master-instance-ipv4-address" {
  value       = digitalocean_droplet.do-kubernetes-master-instance.*.ipv4_address
  description = "Kubernetes master instance IPv4 address"
}

output "do-node-instance-ipv4-address" {
  value       = digitalocean_droplet.do-kubernetes-node-instance.*.ipv4_address
  description = "Kubernetes node instance IPv4 address"
}
