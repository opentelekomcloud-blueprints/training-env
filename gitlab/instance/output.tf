###
# Outputs of Module
#

output "instance_ids" {
   value = "${opentelekomcloud_compute_instance_v2.instance.*.id}"
}

output "instance_ips" {
   value = "${opentelekomcloud_compute_instance_v2.instance.*.access_ip_v4}"
}


