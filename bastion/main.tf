# Configure the OpenTelekomCloud Provider

# User for Identity Project CA_PaaS
provider "opentelekomcloud" {
  alias       = "server"
  region      = "eu-de"
}

# Network
data "opentelekomcloud_vpc_subnet_v1" "subnet_bastion" {
  name   = "${var.subnet_name_bastion}"
}

###
# Loadbalancer
###
module "loadbalancer" {
        source = "loadbalancer"
        providers = {
           opentelekomcloud = "opentelekomcloud.server"
        }
        vpc_id     = "${data.opentelekomcloud_vpc_subnet_v1.subnet_bastion.vpc_id}"
        subnet_id  = "${data.opentelekomcloud_vpc_subnet_v1.subnet_bastion.subnet_id}"
        instance_ips = "${module.instance.instance_ips}"
        keypair_file_private = "${var.keypair_file_private}"
        instance_count = "${var.instance_count}"
        instance_name_prefix = "${var.instance_name_prefix}"
}

###
# Instances
###
module "instance" {
        source = "instance"
        providers = {
           opentelekomcloud = "opentelekomcloud.server"
        }

        instance_count = "${var.instance_count}"
        instance_name_prefix = "${var.instance_name_prefix}"
        image_name = "${var.instance_image_name}"
        flavor_name = "${var.instance_flavor_name}"
        network_id = "${data.opentelekomcloud_vpc_subnet_v1.subnet_bastion.id}"
        subnet_id  = "${data.opentelekomcloud_vpc_subnet_v1.subnet_bastion.subnet_id}"
        secgrp_name = "${module.security.secgrp_server_name}"
        keypair_name = "keypair_bastion"
        keypair_file_private = "${var.keypair_file_private}"
}

###
# Instance Configuration
###
module "configuration" {
        source = "ansible"
        providers = {
           opentelekomcloud = "opentelekomcloud.server"
        }

        instance_count = "${var.instance_count}"
        public_ip = "${module.loadbalancer.elastic_lb_ip}"
        instance_ips = "${module.instance.instance_ips}" 
        keypair_file_private = "${var.keypair_file_private}"
}


###
# Security
###
module "security" {
        source = "security"
        providers = {
           opentelekomcloud = "opentelekomcloud.server"
        }

        keypair_file = "${var.keypair_file}"
        instance_name_prefix = "${var.instance_name_prefix}"
}

