#!/bin/bash

set -e

# copy tfvars and SSH keys from S3
if [ ! -f ./terraform.tfvars ] || [ ! -f ./cncf_key ] || [ ! -f ./cncf_key.pub ]; then
  docker container run \
    --name awscli \
    --rm -i \
    -v "$PWD/:/data" \
    -w /data \
    --env AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
    --env AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
    --env AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION" \
    --entrypoint "" \
    amazon/aws-cli:2.0.20 sh -c \
    "aws s3 cp s3://blackdevs-aws/terraform/cncf-project/terraform.tfvars ./terraform.tfvars && \
    aws s3 cp s3://blackdevs-aws/terraform/cncf-project/cncf_key ./cncf_key && \
    aws s3 cp s3://blackdevs-aws/terraform/cncf-project/cncf_key.pub ./cncf_key.pub && \
    chmod 400 cncf_key cncf_key.pub"
fi

# deploy Terraform scripts
docker container run \
  --name terraform \
  --rm -it \
  -v "$PWD/:/data" \
  -w /data \
  --env AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  --env AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  --env AWS_DEFAULT_REGION="$AWS_DEFAULT_REGION" \
  --entrypoint "" \
  hashicorp/terraform:0.12.24 sh -c \
  "terraform init -backend=true && \
  terraform validate && \
  terraform plan && \
  terraform apply -auto-approve"
