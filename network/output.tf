output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "proxy_sg_id" {
  description = "ID of proxy security group"
  value       = aws_security_group.proxy.id
}

output "backend_sg_id" {
  description = "ID of backend security group"
  value       = aws_security_group.backend.id
}

output "public_lb_sg_id" {
  description = "ID of public load balancer security group"
  value       = aws_security_group.public_lb.id
}

output "private_lb_sg_id" {
  description = "ID of private load balancer security group"
  value       = aws_security_group.private_lb.id
}