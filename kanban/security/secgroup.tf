# Generate Security Groups
#

# Security Group 
resource "opentelekomcloud_compute_secgroup_v2" "secgrp" {
  name        = "secgrp-${var.instance_name_prefix}"
  description = "Security Group for ${var.instance_name_prefix} server"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}
