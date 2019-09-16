###
# Outputs of Module
#

output "instance_ids" {
   value = "${opentelekomcloud_compute_instance_v2.bastion.*.id}"
}

output "instance_ips" {
   value = "${opentelekomcloud_compute_instance_v2.bastion.*.access_ip_v4}"
}


