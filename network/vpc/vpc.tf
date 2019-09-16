# VPC for Training
#

# Create VPC
resource "opentelekomcloud_vpc_v1" "vpc" {
  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"
  shared = true
}

