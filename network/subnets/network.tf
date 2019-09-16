# Subnets 
#

# Create Subnets
resource "opentelekomcloud_vpc_subnet_v1" "vpc-network" {
  count      = "${length(var.subnets)}"
  name       = "${element(var.subnets, count.index)}"
  vpc_id     = "${var.vpc_id}"
  cidr       = "${cidrsubnet(var.vpc_cidr, 8, format("%d0", count.index+1))}"
  gateway_ip = "${cidrhost(cidrsubnet(var.vpc_cidr, 8, format("%d0", count.index+1)), 1)}"
  primary_dns = "100.125.4.25"
  secondary_dns = "8.8.4.4"
}


