###
# Outputs of Module
#

output "instance_ids" {
   value = "${opentelekomcloud_compute_instance_v2.student.*.id}"
}

output "instance_ips" {
   value = "${opentelekomcloud_compute_instance_v2.student.*.access_ip_v4}"
}


