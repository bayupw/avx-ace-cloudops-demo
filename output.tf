output "aws_spoke_1_instance_private_ip" {
  value = "${aws_instance.aws_spoke_1_instance.private_ip}"
}

output "azure_spoke_1_vm_private_ip" {
  value = "${module.azure_spoke_1_vm.network_interface_private_ip}"
}