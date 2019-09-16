# Configure the OpenTelekomCloud Provider

# User for Identity Project CA_PaaS
provider "opentelekomcloud" {
  alias       = "server"
  region      = "eu-de"
}

# VPC
module "vpc" {
 	source = "vpc"
	providers = {
           opentelekomcloud = "opentelekomcloud.server" 
        }

 	vpc_name = "${var.vpc_name}"
        vpc_cidr = "${var.vpc_cidr}"
}

# Network
module "subnets" {
  source = "subnets"
  providers = {
    opentelekomcloud = "opentelekomcloud.server" 
  }

  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr = "${var.vpc_cidr}"
  subnets = "${var.subnets}"
}

