#!/bin/bash

set -e

pushd ./terraform/

# deploy infrastucture with Terraform scripts
chmod +x ./deploy.sh && \
    bash ./deploy.sh

export FQDN="${FQDN:-blackdevs.com.br}"

export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-"sa-east-1"}"
AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:?"[ERROR] Missing AWS Access Key"}"
AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:?"[ERROR] Missing AWS Secret Key"}"

# generate the inventory with instances from Terraform scripts
cat <<EOF | tee ../inventory/main.yml
all:
  vars:
    ansible_ssh_user: root
    cert_domain_name: registry.ondo.${FQDN}
    cert_admin_email: julio@${FQDN}
  children:
    kubernetes:
      children:
        masters:
          vars:
            linkerd_url: linkerd.ondo.${FQDN}
          hosts:
            $(terraform output do-master-instance-ipv4-address-0):
        nodes:
          hosts:
            $(terraform output do-node-instance-ipv4-address-0):
            $(terraform output do-node-instance-ipv4-address-1):
    registry:
      hosts:
        registry.ondo.${FQDN}
EOF

# generate some password for Harbor
export HARBOR_ADMIN="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n1)"
echo "HARBOR_ADMIN :: ${HARBOR_ADMIN}"

# Wait some time
echo "Waiting for instances to be up and running"
sleep 30

popd

# run the playbooks
ansible-playbook registry-playbook.yml
ansible-playbook kubernetes-playbook.yml
