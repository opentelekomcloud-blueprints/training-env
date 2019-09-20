${ip} ansible_ssh_common_args=\x27-o ProxyCommand=\x22ssh -o StrictHostKeyChecking=no -v %r@${bastion_ip} -p 2222 -i ${bastion_cert_path} nc -w 1 %h %p\x22\x27
