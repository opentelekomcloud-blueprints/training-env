### Network
############################

variable "subnet_name_management" {
   default = "student"
}

### Student Server Specifications
#################################

variable "instance_count" {
   default = "25"
}

variable "instance_name_prefix" {
   default = "student"
}

variable "instance_image_name" {
   default = "Standard_CentOS_7_latest"
}

variable "instance_flavor_name" {
   default = "s2.medium.1"
}


### Security Specifications
############################

variable "keypair_file" {
   default = "../keys/student.pub"
}

variable "keypair_file_private" {
   default = "../keys/student.pem"
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



