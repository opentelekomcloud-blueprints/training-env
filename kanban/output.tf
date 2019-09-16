# Output Section
###

output "Instances" {
   value = ["${module.instance.instance_ids}"]
}

output "Elastic IP" {
   value = "${data.openstack_networking_floatingip_v2.floatingip.address}" 
}

output "Kanban Listner ID" {
   value = "${module.loadbalancer.listner_id}"
}

output "Kanvan Pool ID" {
   value = "${module.loadbalancer.pool_id}"
}

