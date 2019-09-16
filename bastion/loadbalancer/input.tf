###
# Inputs of Module
#

variable "vpc_id" {
        description = "VPC Id for Logon Server VPC"
}

variable "subnet_id" {
        description = "Network Id for Logon Server VPC"
}

variable "instance_ips" {
        type = "list"
        description = "List with Instance IPs"
}

variable "keypair_file_private" {
        description = "Path to private Keypair File"
}

variable "instance_count" {
  description = "Amount of Instnaces to be inserted into lb group"
}

variable "instance_name_prefix" {
  description = "Name Prefix"
}
