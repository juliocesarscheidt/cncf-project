# AWS records
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

# Digital Ocean records
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
