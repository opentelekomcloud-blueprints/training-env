###
# Outputs of Module
#

output "elastic_lb_ip" {
   value = "${opentelekomcloud_vpc_eip_v1.eip_lb.publicip.0.ip_address}"
}

output "lb_pool_jmp" {
   value = "${opentelekomcloud_lb_pool_v2.pool.0.id}"
}

