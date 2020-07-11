output "do-instance-ipv4-address" {
  value       = digitalocean_droplet.do-instance.ipv4_address
  sensitive   = false
  description = "Droplet IPv4 address"
}

output "do-instance-status" {
  value       = digitalocean_droplet.do-instance.status
  sensitive   = false
  description = "Droplet status"
}

output "do-registry-domain-name" {
  value       = digitalocean_domain.do-registry-domain.name
  sensitive   = false
  description = "Registry domain name"
}
