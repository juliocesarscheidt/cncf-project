#!/bin/bash

set -e

terraform init && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve
