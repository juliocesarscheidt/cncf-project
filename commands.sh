# ansible
ansible all -m ping
ansible all -m shell -a "uptime"

# random password for admin user on Harbor
export HARBOR_ADMIN=3kjDqy7TDs6iHr6IL

ansible-playbook registry-playbook.yml
ansible-playbook registry-playbook.yml -v

ansible-playbook kubernetes-playbook.yml
ansible-playbook kubernetes-playbook.yml -v

# ansible config precedence
# ANSIBLE_CONFIG (environment variable if set)
# ansible.cfg (in the current directory)
# ~/.ansible.cfg (in the home directory)
# /etc/ansible/ansible.cfg

# SSH
pushd ./terraform/

# terraform fmt -write=true -recursive

# terraform refresh
# terraform destroy -auto-approve


# access registry
ssh -i cncf_key root@$(terraform output do-registry-instance-ipv4-address)

ssh -i cncf_key root@$(terraform output do-registry-instance-ipv4-address) -a "apt-get update -yqq && apt-get install -yqq python-minimal"


# get IPs from node
terraform output do-node-instance-ipv4-address-0
terraform output do-node-instance-ipv4-address-1


# get IPs from master
terraform output do-master-instance-ipv4-address-0

ssh -i cncf_key root@$(terraform output do-master-instance-ipv4-address-0)


# copy certs (registry.ondo.blackdevs.com.br)
aws s3 cp ./certs/cert.pem s3://blackdevs-aws/terraform/cncf-project/cert.pem
aws s3 cp ./certs/chain.pem s3://blackdevs-aws/terraform/cncf-project/chain.pem
aws s3 cp ./certs/fullchain.pem s3://blackdevs-aws/terraform/cncf-project/fullchain.pem
aws s3 cp ./certs/privkey.pem s3://blackdevs-aws/terraform/cncf-project/privkey.pem

aws s3 ls s3://blackdevs-aws/terraform/cncf-project/


# remove from known_hosts
# ssh-keygen -R $(terraform output do-master-instance-ipv4-address-0)


# copy kubeconfig from master
scp -i cncf_key root@$(terraform output do-master-instance-ipv4-address-0):~/.kube/config ./kubeconfig
export KUBECONFIG=$PWD/kubeconfig


# inject inject sidecars on some Kubernetes objects
linkerd inject [FILE].yaml | kubectl apply -f -


# benchmark
docker run --rm --net=host \
  jordi/ab -c 100 -n 5000 \
  -H "Host: todoapp.ondo.blackdevs.com.br" \
  https://todoapp.ondo.blackdevs.com.br/
