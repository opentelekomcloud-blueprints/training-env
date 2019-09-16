# Prepare and call Ansible
##########################

data "template_file" "inventory" {
  count = "${var.instance_count}"
  template = "${file("${path.module}/templates/inventory.tpl")}"
  vars {
    name  = "${format("kanban%02d", count.index+1)}"
    ip = "${element(var.instance_ips, count.index)}"
    bastion_ip = "${var.public_ip}"
    bastion_cert_path = "${path.module}/../../keys/bastion.pem"
  }
}

resource "null_resource" "update_inventory" {
  triggers {
    template = "${data.template_file.inventory.0.rendered}"
  }
  count = "${var.instance_count}"

  # Generate inventory,
  provisioner "local-exec" {
    working_dir = "${path.module}/"
    command = "echo '${join(" ", data.template_file.inventory.*.rendered)}' > ${path.module}/inventory"
  }
}

resource "null_resource" "execute_ansible" {
  triggers {
    template = "${var.instance_ips[0]}"
  }

  # Wait until Instance is up and running
  provisioner "remote-exec" {
    inline = ["uptime"]
    connection {
      type        = "ssh"
      host        = "${element(var.instance_ips, count.index)}"
      port        = "22"
      user        = "linux"
      agent       = "false"
      private_key = "${file(var.keypair_file_private)}"
      bastion_host = "${var.public_ip}"
      bastion_port = "2222"
      bastion_user = "linux"
      bastion_private_key = "${file(var.keypair_file_private)}"
    }
  }

  # Execute configuration with ansible,
  provisioner "local-exec" {
    working_dir = "${path.module}/"
    command = "ansible-playbook -i inventory playbook.yml --limit ${element(var.instance_ips, count.index)}"
  }
}

