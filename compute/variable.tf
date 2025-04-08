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

variable "proxy_sg_id" {
  description = "Security group ID for proxy instances"
  type        = string
}

variable "backend_sg_id" {
  description = "Security group ID for backend instances"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}