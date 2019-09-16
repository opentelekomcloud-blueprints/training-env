###
# Inputs of Module
#

variable "instance_count" {
  description = "Amount of instances to be created"
  default = "1"
}

variable "public_ip" {
  description = "Public IP to connect to server with ssh"
}

variable "instance_ips" {
  type = "list"
  description = "Instances IPs"
}

variable "keypair_file_private" {
  description = "Certificate to log into bastion host"
}

