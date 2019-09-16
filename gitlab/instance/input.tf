###
# Inputs of Module
#

# Kanban Host
#

variable "instance_count" {
  description = "Amount of instances to be created"
  default = "1"
}

variable "instance_name_prefix" {
  description = "Prefix for Instance"
}

variable "image_name" {
  description = "Name of Image"
}

variable "flavor_name" {
  description = "Flavor Name of Server"
}

variable "network_id" {
  description = "Network for Server"
}

variable "subnet_id" {
  description = "ID für das Bastion-Subnet"
}

variable "secgrp_name" {
  description = "Security Group Name"
}

variable "keypair_name" {
  description = "Keypair for Connection"
}

variable "keypair_file_private" {
  description = "Private Keypair for Connection"
}


