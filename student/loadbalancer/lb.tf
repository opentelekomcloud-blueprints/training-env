# Loadbalaner to Internet
#

data "external" "elb" {
  program = ["bash", "${path.module}/get_elb.sh"]
  query = {
    username="${var.username}"
    password="${var.password}"
    domain="${var.domain_name}"
    project="${var.project_name}"
  }
}

# Create Listner 
resource "opentelekomcloud_lb_listener_v2" "listener" {
  count            = "${var.instance_count}"
  name             = "${var.instance_name_prefix}-listener${format("%02d", count.index+1)}"
  protocol         = "TCP"
  protocol_port    = "80${format("%02d", count.index+1)}"
  loadbalancer_id  = "${data.external.elb.result.lbid}"
  admin_state_up   = "true"
}

# Create Backend Server Group
resource "opentelekomcloud_lb_pool_v2" "pool" {
  count       = "${var.instance_count}"
  name        = "${var.instance_name_prefix}_${count.index + 1}"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${element(opentelekomcloud_lb_listener_v2.listener.*.id, count.index)}"
}

# Connectivity throught LB
# Add Server to Server Group
resource "opentelekomcloud_lb_member_v2" "member" {
  count          = "${var.instance_count}"
  address       = "${element(var.instance_ips, count.index)}"
  pool_id       = "${element(opentelekomcloud_lb_pool_v2.pool.*.id, count.index)}"
  subnet_id  = "${var.subnet_id}"
  protocol_port = 80
}

