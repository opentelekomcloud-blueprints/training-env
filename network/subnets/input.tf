###
# Inputs of Module
#

variable "vpc_id" {
  description = "Id of VPC where subnets should be created in"
}

variable "vpc_cidr" {
  description = "Cidr of vpc"
}

variable "subnets" {
  type = "list"
  description = "Subnet Names to create"
}

