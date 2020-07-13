#!/bin/bash

set -e

terraform fmt -write=true -recursive

terraform init -backend=false && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve

# terraform refresh

# terraform destroy -auto-approve
