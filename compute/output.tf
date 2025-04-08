output "proxy_public_ips" {
  description = "Public IP addresses of proxy instances"
  value       = aws_instance.proxy[*].public_ip
}

output "backend_private_ips" {
  description = "Private IP addresses of backend instances"
  value       = aws_instance.backend[*].private_ip
}

output "backend_instance_ids" {
  description = "IDs of backend instances"
  value       = aws_instance.backend[*].id
}