#!/bin/bash

set -e

pushd ./terraform/

# deploy infrastucture with Terraform scripts
chmod +x ./deploy.sh && \
    bash ./deploy.sh

export FQDN="${FQDN:-blackdevs.com.br}"

export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-"sa-east-1"}"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:?"[ERROR] Missing AWS Access Key"}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:?"[ERROR] Missing AWS Secret Key"}"

# generate the inventory with instances from Terraform scripts
cat <<EOF | tee ../inventory/main.yml
all:
  vars:
    fqdn: ${FQDN}
    ansible_ssh_user: root
    cert_domain_name: registry.ondo.${FQDN}
    cert_admin_email: julio@${FQDN}
  children:
    kubernetes:
      children:
        masters:
          vars:
            linkerd_fqdn: linkerd.ondo.${FQDN}
          hosts:
            $(terraform output do-master-instance-ipv4-address-0):
        nodes:
          hosts:
            $(terraform output do-node-instance-ipv4-address-0):
            $(terraform output do-node-instance-ipv4-address-1):
    registry:
      hosts:
        registry.ondo.${FQDN}
    front-proxy:
      hosts:
        k8s.ondo.${FQDN}
EOF

# generate some password for Harbor if not set
declare -x RANDOM_PASS
RANDOM_PASS="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)"

declare -x HARBOR_ADMIN
HARBOR_ADMIN="${HARBOR_ADMIN:-$RANDOM_PASS}"

echo "HARBOR_ADMIN :: ${HARBOR_ADMIN}"

# Wait some time
echo "Waiting for instances to be up and running"
sleep 45

popd

# run the playbooks
ansible-playbook registry-playbook.yml
ansible-playbook kubernetes-playbook.yml
ansible-playbook front-proxy-playbook.yml
ansible-playbook application-playbook.yml
