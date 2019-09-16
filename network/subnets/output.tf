###
# Outputs of Module
#

output "network_id" {
   value = "${opentelekomcloud_vpc_subnet_v1.vpc-network.*.id}"
}

