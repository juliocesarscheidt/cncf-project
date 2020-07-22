output "do-registry-instance-ipv4-address" {
  value       = digitalocean_droplet.do-registry-instance.ipv4_address
  description = "Registry instance IPv4 address"
}

output "do-front-proxy-instance-ipv4-address" {
  value       = digitalocean_droplet.do-front-proxy-instance.ipv4_address
  description = "Front Proxy instance IPv4 address"
}

output "do-master-instance-ipv4-address-0" {
  value       = digitalocean_droplet.do-kubernetes-master-instance.0.ipv4_address
  description = "Kubernetes master instance IPv4 address"
}

output "do-node-instance-ipv4-address-0" {
  value       = digitalocean_droplet.do-kubernetes-node-instance.0.ipv4_address
  description = "Kubernetes node instance IPv4 address"
}

output "do-node-instance-ipv4-address-1" {
  value       = digitalocean_droplet.do-kubernetes-node-instance.1.ipv4_address
  description = "Kubernetes node instance IPv4 address"
}
