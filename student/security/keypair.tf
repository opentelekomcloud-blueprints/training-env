# Create Keypair
#

resource "opentelekomcloud_compute_keypair_v2" "keypair" {
  name       = "keypair_${var.instance_name_prefix}"
  public_key = "${file("${var.keypair_file}")}"
}

