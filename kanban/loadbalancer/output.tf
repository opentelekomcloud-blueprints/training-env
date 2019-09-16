###
# Outputs of Module
#

output "listner_id" {
   value = "${opentelekomcloud_lb_listener_v2.listener.0.id}"
}

output "pool_id" {
   value = "${opentelekomcloud_lb_pool_v2.pool.0.id}"
}

