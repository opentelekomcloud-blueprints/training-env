# Create Server
#

data "opentelekomcloud_images_image_v2" "image_centos" {
  name = "Standard_CentOS_7_latest"
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "opentelekomcloud_blockstorage_volume_v2" "volume" {
  count = "${var.instance_count}"
  name = "${var.instance_name_prefix}-${format("%02d", count.index+1)}"
  size  = "5"
  image_id = "${data.opentelekomcloud_images_image_v2.image_centos.id}"
}

resource "opentelekomcloud_blockstorage_volume_v2" "data" {
  name = "${var.instance_name_prefix}-data-${format("%02d", count.index+1)}"
  size = 10
}

resource "opentelekomcloud_compute_instance_v2" "instance" {
  count           = "${var.instance_count}"
  name            = "${var.instance_name_prefix}-${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${var.keypair_name}"
  security_groups = [
    "${var.secgrp_name}"
  ]

  block_device {
    uuid                  = "${element(opentelekomcloud_blockstorage_volume_v2.volume.*.id, count.index)}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  block_device {
    uuid                  = "${opentelekomcloud_blockstorage_volume_v2.data.id}"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 1
    delete_on_termination = true
  }
  network {
    uuid           = "${var.network_id}"
    fixed_ip_v4    = "10.100.30.10${format("%d", count.index+1)}"
  }
}

