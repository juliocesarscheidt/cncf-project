terraform {
  required_version = "~> 0.12.0"

  required_providers {
    digitalocean = "~> 1.22.0"
    aws          = "~> 3.0"
  }

  backend "s3" {
    bucket = "blackdevs-aws"
    key    = "terraform/cncf-project/state.tfstate"
    region = "sa-east-1"
  }
}

