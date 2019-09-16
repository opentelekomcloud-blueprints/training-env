# Prepare and call Ansible
##########################

data "template_file" "inventory" {
  count = "${var.instance_count}"
  template = "${file("${path.module}/templates/inventory.tpl")}"
  vars {
    name  = "${format("bastion%02d", count.index+1)}"
    ip = "${element(var.instance_ips, count.index)}"
    bastion_ip = "${var.public_ip}"
  }
}

resource "null_resource" "update_inventory" {
  triggers {
    template = "${data.template_file.inventory.0.rendered}"
  }
    
  # Write inventory file
  provisioner "local-exec" {
    command = "echo '${join(" ", data.template_file.inventory.*.rendered)}' > ${path.module}/inventory"
  }

  # Wait until Instance is up and running
  provisioner "remote-exec" {
    inline = ["uptime"]
    connection {
      type        = "ssh"
      host        = "${var.public_ip}"
      port        = "2222"
      user        = "linux"
      agent       = "false"
      private_key = "${file(var.keypair_file_private)}"
    }
  }

  # Execute configuration with ansible
  provisioner "local-exec" {
    working_dir = "${path.module}/"
    command     = "ansible-playbook -i inventory playbook.yml"
  }
}

