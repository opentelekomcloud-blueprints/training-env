### VCP Specifications
############################

variable "vpc_name" {
   default = "VPC"
}
variable "vpc_cidr" {
   default = "10.100.0.0/16"
}

### Subnet Specifications
############################

# https://www.terraform.io/docs/configuration-0-11/interpolation.html

# https://www.terraform.io/docs/configuration/types.html

# Da Terraform Version < 0.12 Probleme hat Listen von komplexen 
# Objekten zu verarbeiten, wird das erste Netzwerk in der Liste
# als Netzwerk für den Loadbalancer genommen. vgl. loadbalancer.tf

variable "subnets" {
   type = "list"
   default = ["bastion", "management", "tools", "student"]
}

