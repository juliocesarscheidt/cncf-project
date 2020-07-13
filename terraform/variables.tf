# Digital Ocean variables
variable "do_token" {
  type        = string
  description = "Digital Ocean token"
}

variable "do_ssh_keys" {
  type        = list(number)
  description = "Digital Ocean SSH keys"
}

variable "do_region" {
  type        = string
  description = "Digital Ocean region"
  default     = "nyc3"
}

variable "do_image" {
  type        = string
  description = "Digital Ocean instance image"
  default     = "ubuntu-18-04-x64"
}

variable "do_size" {
  type        = string
  description = "Digital Ocean instance size"
  # 2 vCPUs, 4096 Memory
  default = "s-2vcpu-4gb"
}

variable "do_kubernetes_master_count" {
  type        = number
  description = "Digital Ocean number of Kubernetes master instances"
  default     = 1
}

variable "do_kubernetes_node_count" {
  type        = number
  description = "Digital Ocean number of Kubernetes node instances"
  default     = 2
}

# AWS variables
variable "aws_access_key" {
  type        = string
  description = "AWS access key ID"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret access Key"
}

variable "aws_hosted_zone_id" {
  type        = string
  description = "AWS hosted zone ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "sa-east-1"
}

# Miscellaneous
variable "domain" {
  type        = string
  description = "Domain used to deploy"
  default     = "blackdevs.com.br"
}
