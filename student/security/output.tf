###
# Outputs of Module
#

output "secgrp_server_name" {
   value = "${opentelekomcloud_compute_secgroup_v2.secgrp.name}"
}

output "keypair" {
   value = "${opentelekomcloud_compute_keypair_v2.keypair.name}"
}

