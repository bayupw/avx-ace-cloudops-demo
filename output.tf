output "prod_backup_private_ip" {
  value = "${aws_instance.prod_backup_instance.private_ip}"
}

output "prod_app_private_ip" {
  value = "${prod_app_vm.network_interface_private_ip}"
}