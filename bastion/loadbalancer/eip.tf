# EIP for Loadbalancer
resource "opentelekomcloud_vpc_eip_v1" "eip_lb" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name = "eip_lb"
    size = "50"
    share_type = "PER"
  }
}

