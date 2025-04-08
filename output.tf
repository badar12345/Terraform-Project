output "public_lb_dns" {
  description = "DNS name of public load balancer"
  value       = module.loadbalancer.public_lb_dns
}

output "proxy_public_ips" {
  description = "Public IP addresses of proxy instances"
  value       = module.compute.proxy_public_ips
}

output "all_ips_file" {
  description = "Path to the generated all-ips.txt file"
  value       = local_file.all_ips.filename
}