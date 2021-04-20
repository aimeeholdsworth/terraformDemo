output "net_id"{
    value = aws_network_interface.web-server-nic.id
}

output "net_id_test"{
    value = aws_network_interface.test-nic.id
}

output "net_id_jenkins"{
    value = aws_network_interface.jenkins-nic.id
}

output "nat_gate_id" {
  value = aws_nat_gateway.gw.id
}

output "subnet_group_name" {
    value = aws_db_subnet_group.private-group.name
  
}

output "server_public_ip" {
    value = aws_eip.one.public_ip
}