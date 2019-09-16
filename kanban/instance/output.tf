###
# Outputs of Module
#

output "instance_ids" {
   value = "${opentelekomcloud_compute_instance_v2.kanban.*.id}"
}

output "instance_ips" {
   value = "${opentelekomcloud_compute_instance_v2.kanban.*.access_ip_v4}"
}


