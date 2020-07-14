# AWS records
# registry
resource "aws_route53_record" "aws-registry-ns-record" {
  allow_overwrite = false
  name            = "registry.ondo.${var.domain}"
  ttl             = 30
  type            = "NS"
  zone_id         = var.aws_hosted_zone_id

  records = [
    "ns3.digitalocean.com.",
    "ns2.digitalocean.com.",
    "ns1.digitalocean.com.",
  ]

  depends_on = [digitalocean_droplet.do-registry-instance]
}

# nodes
resource "aws_route53_record" "aws-kubernetes-node-ns-record" {
  allow_overwrite = false
  name            = "linkerd.ondo.${var.domain}"
  ttl             = 30
  type            = "NS"
  zone_id         = var.aws_hosted_zone_id

  records = [
    "ns3.digitalocean.com.",
    "ns2.digitalocean.com.",
    "ns1.digitalocean.com.",
  ]

  depends_on = [digitalocean_droplet.do-kubernetes-node-instance]
}

# Digital Ocean records
# registry
resource "digitalocean_domain" "do-registry-domain" {
  name = "registry.ondo.${var.domain}"

  depends_on = [aws_route53_record.aws-registry-ns-record]
}

resource "digitalocean_record" "do-registry-a-record" {
  domain = digitalocean_domain.do-registry-domain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.do-registry-instance.ipv4_address

  depends_on = [digitalocean_domain.do-registry-domain]
}

# nodes
resource "digitalocean_domain" "do-kubernetes-node-domain" {
  name = "linkerd.ondo.${var.domain}"

  depends_on = [aws_route53_record.aws-kubernetes-node-ns-record]
}

resource "digitalocean_record" "do-kubernetes-node-a-record" {
  count = var.do_kubernetes_node_count

  domain = element(digitalocean_domain.do-kubernetes-node-domain.*.name, count.index)
  type   = "A"
  name   = "@"
  value  = element(digitalocean_droplet.do-kubernetes-node-instance.*.ipv4_address, count.index)

  depends_on = [digitalocean_domain.do-kubernetes-node-domain]
}
