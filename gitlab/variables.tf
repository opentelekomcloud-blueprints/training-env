### Network
############################

variable "subnet_name_management" {
   default = "tools"
}

### gitlab Server Specifications
#################################

variable "instance_count" {
   default = "1"
}

variable "instance_name_prefix" {
   default = "gitlab"
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
   default = "../keys/gitlab.pub"
}

variable "keypair_file_private" {
   default = "../keys/gitlab.pem"
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


