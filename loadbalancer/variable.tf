variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_lb_sg_id" {
  description = "Security group ID for public load balancer"
  type        = string
}

variable "private_lb_sg_id" {
  description = "Security group ID for private load balancer"
  type        = string
}

variable "backend_instance_ids" {
  description = "List of backend instance IDs"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}