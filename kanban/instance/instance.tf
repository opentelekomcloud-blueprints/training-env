# Create Server
#

resource "opentelekomcloud_compute_instance_v2" "kanban" {
  count           = "${var.instance_count}"
  name            = "${var.instance_name_prefix}-${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${var.keypair_name}"
  security_groups = [
    "${var.secgrp_name}"
  ]
  network {
    uuid           = "${var.network_id}"
    fixed_ip_v4    = "10.100.20.10${format("%d", count.index+1)}"
  }
}

