output "instance_id" {
  description = "ID of the Windows EC2 instance"
  value       = aws_instance.windows_vm.id
}

output "public_ip" {
  description = "Public IPv4 address of the Windows EC2 instance"
  value       = aws_instance.windows_vm.public_ip
}

output "rdp_security_group_id" {
  description = "Security group ID with restricted RDP ingress"
  value       = aws_security_group.windows_rdp.id
}
