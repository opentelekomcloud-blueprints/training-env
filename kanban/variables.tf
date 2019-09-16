### Network
############################

variable "subnet_name_management" {
   default = "management"
}

### Kanban Server Specifications
#################################

variable "instance_count" {
   default = "1"
}

variable "instance_name_prefix" {
   default = "kanban"
}

variable "instance_image_name" {
   default = "Standard_CentOS_7_latest"
}

variable "instance_flavor_name" {
   default = "s1.medium"
}


### Security Specifications
############################

variable "keypair_file" {
   default = "../keys/bastion.pub"
}

variable "keypair_file_private" {
   default = "../keys/bastion.pem"
}

### OTC Tenant Specification for direct Rest API Calls
############################

variable "username" {
}

variable "password" {
}

variable "domain_name" {
}

variable "tenant_name" {
}

############################


