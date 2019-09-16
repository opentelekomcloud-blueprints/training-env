###
# Inputs of Module
#

variable "project_id" {
        description = "Project Id of IAM Projekt"
}

variable "subnet_id" {
        description = "Subnetwork Id for Kanban Server VPC"
}

variable "instance_ips" {
        type = "list"
        description = "List with Instance IPs"
}

variable "instance_name_prefix" {
        description = "Prefix of Name"
}

variable "keypair_file_private" {
        description = "Path to private Keypair File"
}

variable "instance_count" {
  description = "Amount of Instnaces to be inserted into lb group"
}

variable "username" {
  description = "Username to access Tenant"
}

variable "password" {
  description = "Password of User to access Tenant"
}

variable "domain_name" {
  description = "Domain of OTC"
}

variable "project_name" {
  description = "Name of Project"
}

