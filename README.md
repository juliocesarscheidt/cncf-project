# CNCF project 🐳🚀

[![Build Status](https://travis-ci.org/julio-cesar-development/cncf-project.svg)](https://travis-ci.org/julio-cesar-development/cncf-project)
[![GitHub Status](https://badgen.net/github/status/julio-cesar-development/cncf-project)](https://github.com/julio-cesar-development/cncf-project)
![License](https://badgen.net/badge/license/MIT/blue)

> This is a project to provide a Kubernetes infrastucture using Terraform and Ansible, also a Harbor registry for Docker images.<br>
> Implemented totally as IAC (Infrastructure as Code)<br>
> It will be used CNCF (Cloud Native Computing Foundation) projects the whole implementation of this project.<br>

---

## Instructions

```bash
# required variables
export FQDN="$FQDN"
export AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION"
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export HARBOR_ADMIN="$HARBOR_ADMIN"
export DO_TOKEN="$DO_TOKEN"
export DO_SSH_KEY_ID="$DO_SSH_KEY_ID"

cat <<EOF | tee ./terraform/terraform.tfvars
do_token           = "$DO_TOKEN"
do_ssh_keys        = [$DO_SSH_KEY_ID]
aws_access_key     = "$AWS_ACCESS_KEY_ID"
aws_secret_key     = "$AWS_SECRET_ACCESS_KEY"
aws_hosted_zone_id = "$AWS_HOSTED_ZONE_ID"
EOF

# deploy
chmod +x deploy.sh && \
    bash deploy.sh
```

---

## Used tools

> - [x] Docker<br>
> - [x] Kubernetes<br>
> - [x] Terraform<br>
> - [x] Ansible<br>
> - [x] Helm<br>
> - [x] Harbor<br>
> - [x] Linkerd<br>
> - [x] Envoy<br>
> - [x] Contour<br>
> - [x] Cert Manager / Letsencrypt<br>

## Tests

```bash
# benchmark
docker run --rm --net=host \
  jordi/ab -c 1000 -n 10000 \
  -H "Host: todoapp.ondo.$FQDN" \
  https://todoapp.ondo.$FQDN/
```

## Linkerd

> Linkerd Dashboard

![Linkerd](https://raw.githubusercontent.com/julio-cesar-development/cncf-project/master/linkerd.png)

## Docs

> harbor

[https://goharbor.io/docs/2.0.0/install-config/download-installer/](https://goharbor.io/docs/2.0.0/install-config/download-installer/)<br>
[https://goharbor.io/docs/2.0.0/install-config/configure-https/](https://goharbor.io/docs/2.0.0/install-config/configure-https/)<br>
[https://goharbor.io/docs/2.0.0/install-config/configure-yml-file/](https://goharbor.io/docs/2.0.0/install-config/configure-yml-file/)<br>
[https://goharbor.io/docs/2.0.0/install-config/quick-install-script/](https://goharbor.io/docs/2.0.0/install-config/quick-install-script/)

> ansible

[https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings)<br>
[https://docs.ansible.com/ansible/latest/plugins/lookup/env.html](https://docs.ansible.com/ansible/latest/plugins/lookup/env.html)<br>
[https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg](https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg)

> contour

[https://projectcontour.io/getting-started/](https://projectcontour.io/getting-started/)<br>
[https://projectcontour.io/guides/ingressroute-to-httpproxy/](https://projectcontour.io/guides/ingressroute-to-httpproxy/)<br>
[https://projectcontour.io/docs/v1.6.1/httpproxy/#header-policy](https://projectcontour.io/docs/v1.6.1/httpproxy/#header-policy)<br>
[https://projectcontour.io/docs/v1.6.1/annotations/](https://projectcontour.io/docs/v1.6.1/annotations/)

> linkerd

[https://linkerd.io/2/getting-started/](https://linkerd.io/2/getting-started/)<br>
[https://linkerd.io/2/tasks/using-ingress/#contour](https://linkerd.io/2/tasks/using-ingress/#contour)<br>
[https://linkerd.io/2/tasks/using-ingress/#nginx](https://linkerd.io/2/tasks/using-ingress/#nginx)

## Authors

[Julio Cesar](https://github.com/julio-cesar-development)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
