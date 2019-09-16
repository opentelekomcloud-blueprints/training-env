# Loadbalaner to Internet
#

# Generate Loadbalancer
resource "opentelekomcloud_lb_loadbalancer_v2" "lb" {
  name           = "lb"
  vip_subnet_id  = "${var.subnet_id}"
  description    = "Loadbalancer for ${var.instance_name_prefix} Server"
  admin_state_up = "true"
}

# Bind IP to LB
resource "opentelekomcloud_networking_floatingip_associate_v2" "fip_lb" {
  floating_ip = "${opentelekomcloud_vpc_eip_v1.eip_lb.publicip.0.ip_address}"
  port_id     = "${opentelekomcloud_lb_loadbalancer_v2.lb.vip_port_id}"
}

# Create Listner
resource "opentelekomcloud_lb_listener_v2" "listener" {
  name             = "Logon-listener"
  protocol         = "TCP"
  protocol_port    = "2222"
  loadbalancer_id  = "${opentelekomcloud_lb_loadbalancer_v2.lb.id}"
  admin_state_up   = "true"
}

# Create Backend Server Group
resource "opentelekomcloud_lb_pool_v2" "pool" {
  count       = "${var.instance_count}"
  name        = "ssh_${var.instance_count}"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${opentelekomcloud_lb_listener_v2.listener.id}"
}

# Connectivity throught LB
# Add Server to Server Group
resource "opentelekomcloud_lb_member_v2" "member" {
  count          = "${var.instance_count}"
  address       = "${element(var.instance_ips, count.index)}"
  pool_id       = "${opentelekomcloud_lb_pool_v2.pool.id}"
  subnet_id  = "${var.subnet_id}"
  protocol_port = 22

}

