#!/bin/bash

set -e

terraform fmt -write=true -recursive

terraform init -backend=false && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve

# terraform refresh

# ssh -i cncf_key -v root@$(terraform output do-instance-ipv4-address)
# ssh -i cncf_key -v root@$(terraform output do-registry-domain-name)

# terraform destroy -auto-approve
