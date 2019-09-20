# Output Section
###

output "Instances" {
   value = ["${module.instance.instance_ids}"]
}

output "Elastic IP" {
   value = "${data.openstack_networking_floatingip_v2.floatingip.address}" 
}

