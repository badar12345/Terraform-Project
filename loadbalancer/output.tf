output "public_lb_dns" {
  description = "DNS name of public load balancer"
  value       = aws_lb.public.dns_name
}

output "private_lb_dns" {
  description = "DNS name of private load balancer"
  value       = aws_lb.private.dns_name
}