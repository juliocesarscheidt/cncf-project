#!/bin/bash

mkdir -p /etc/letsencrypt/live/{{ cert_domain_name }} && \
docker container run \
    --name awscli \
    --rm -i \
    -v /etc/letsencrypt/live/{{ cert_domain_name }}:/data \
    -w /data \
    --env AWS_ACCESS_KEY_ID="{{ lookup('env', 'AWS_ACCESS_KEY_ID') }}" \
    --env AWS_SECRET_ACCESS_KEY="{{ lookup('env', 'AWS_SECRET_ACCESS_KEY') }}" \
    --env AWS_DEFAULT_REGION="{{ lookup('env', 'AWS_DEFAULT_REGION') }}" \
    --entrypoint "" \
    amazon/aws-cli:2.0.20 sh -c \
    "aws s3 cp s3://blackdevs-aws/terraform/cncf-project/cert.pem ./cert.pem && \
    aws s3 cp s3://blackdevs-aws/terraform/cncf-project/chain.pem ./chain.pem && \
    aws s3 cp s3://blackdevs-aws/terraform/cncf-project/fullchain.pem ./fullchain.pem && \
    aws s3 cp s3://blackdevs-aws/terraform/cncf-project/privkey.pem ./privkey.pem"
