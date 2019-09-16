# Output Section
###

output "Instances" {
   value = ["${module.instance.instance_ids}"]
}

output "Elastic IP" {
   value = ["${module.loadbalancer.elastic_lb_ip}"]
}

