# Configure the OpenTelekomCloud Provider

# User for Identity Project CA_PaaS
provider "opentelekomcloud" {
  alias       = "server"
  region      = "eu-de"
}

# Network
data "opentelekomcloud_vpc_v1" "vpc" {
  name = "VPC"
}

data "opentelekomcloud_vpc_subnet_v1" "subnet_management" {
  name   = "${var.subnet_name_management}"
}

data "openstack_networking_floatingip_v2" "floatingip" {
  status = "ACTIVE"
}

# Project ID
data "opentelekomcloud_identity_project_v3" "project" {
  name = "${var.tenant_name}"
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
        network_id = "${data.opentelekomcloud_vpc_subnet_v1.subnet_management.id}"
        subnet_id  = "${data.opentelekomcloud_vpc_subnet_v1.subnet_management.subnet_id}"
        secgrp_name = "${module.security.secgrp_server_name}"
        keypair_name = "keypair_kanban"
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
        public_ip = "${data.openstack_networking_floatingip_v2.floatingip.address}"
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

###
# Loadbalancer
###
module "loadbalancer" {
        source = "loadbalancer"
        providers = {
           opentelekomcloud = "opentelekomcloud.server"
        }
     
        project_id = "${data.opentelekomcloud_identity_project_v3.project.domain_id}"
        subnet_id = "${data.opentelekomcloud_vpc_subnet_v1.subnet_management.subnet_id}"
        instance_ips = "${module.instance.instance_ips}" 
        keypair_file_private = "${var.keypair_file_private}"
        instance_count = "${var.instance_count}"
        username = "${var.username}"
        password = "${var.password}"
        domain_name = "${var.domain_name}"
        project_name = "${var.tenant_name}"
        instance_name_prefix = "${var.instance_name_prefix}"

}

