# AWS records

# k8s front-proxy
# resource "aws_route53_record" "aws-front-proxy-ns-record" {
#   allow_overwrite = false
#   name            = "k8s.ondo.${var.domain}"
#   ttl             = 30
#   type            = "NS"
#   zone_id         = var.aws_hosted_zone_id

#   records = [
#     "ns3.digitalocean.com.",
#     "ns2.digitalocean.com.",
#     "ns1.digitalocean.com.",
#   ]

#   depends_on = [digitalocean_droplet.do-registry-instance]
# }

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

# applications

# linkerd
resource "aws_route53_record" "aws-kubernetes-ns-record-linkerd" {
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

  depends_on = [digitalocean_droplet.do-front-proxy-instance]
}

# todoapp
resource "aws_route53_record" "aws-kubernetes-ns-record-todoapp" {
  allow_overwrite = false
  name            = "todoapp.ondo.${var.domain}"
  ttl             = 30
  type            = "NS"
  zone_id         = var.aws_hosted_zone_id

  records = [
    "ns3.digitalocean.com.",
    "ns2.digitalocean.com.",
    "ns1.digitalocean.com.",
  ]

  depends_on = [digitalocean_droplet.do-front-proxy-instance]
}

# Digital Ocean records

# k8s front proxy
# resource "digitalocean_domain" "do-front-proxy-domain" {
#   name = "k8s.ondo.${var.domain}"

#   depends_on = [aws_route53_record.aws-front-proxy-ns-record]
# }

# resource "digitalocean_record" "do-front-proxy-a-record" {
#   domain = digitalocean_domain.do-front-proxy-domain.name
#   type   = "A"
#   name   = "@"
#   value  = digitalocean_droplet.do-front-proxy-instance.ipv4_address

#   depends_on = [digitalocean_domain.do-front-proxy-domain]
# }

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

resource "digitalocean_record" "do-registry-cname-record" {
  domain   = digitalocean_domain.do-registry-domain.name
  type     = "CNAME"
  name     = "www"
  value    = "@"

  depends_on = [digitalocean_domain.do-registry-domain]
}

# applications
# all domains for applications redirect to front-proxy

# linkerd
resource "digitalocean_domain" "do-kubernetes-domain-linkerd" {
  name = "linkerd.ondo.${var.domain}"

  depends_on = [aws_route53_record.aws-kubernetes-ns-record-linkerd]
}

resource "digitalocean_record" "do-kubernetes-a-record-linkerd" {
  domain = digitalocean_domain.do-kubernetes-domain-linkerd.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.do-front-proxy-instance.ipv4_address

  depends_on = [digitalocean_domain.do-kubernetes-domain-linkerd]
}

resource "digitalocean_record" "do-kubernetes-cname-record-linkerd" {
  domain   = digitalocean_domain.do-kubernetes-domain-linkerd.name
  type     = "CNAME"
  name     = "www"
  value    = "@"

  depends_on = [digitalocean_domain.do-kubernetes-domain-linkerd]
}

# todoapp
resource "digitalocean_domain" "do-kubernetes-domain-todoapp" {
  name = "todoapp.ondo.${var.domain}"

  depends_on = [aws_route53_record.aws-kubernetes-ns-record-todoapp]
}

resource "digitalocean_record" "do-kubernetes-a-record-todoapp" {
  domain = digitalocean_domain.do-kubernetes-domain-todoapp.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.do-front-proxy-instance.ipv4_address

  depends_on = [digitalocean_domain.do-kubernetes-domain-todoapp]
}

resource "digitalocean_record" "do-kubernetes-cname-record-todoapp" {
  domain   = digitalocean_domain.do-kubernetes-domain-todoapp.name
  type     = "CNAME"
  name     = "www"
  value    = "@"

  depends_on = [digitalocean_domain.do-kubernetes-domain-todoapp]
}
